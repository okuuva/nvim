-- cmux backend for sidekick.nvim
-- Discovers sessions via socket (system.tree → TTY → PID), communicates via cmux socket API.
local Config = require("sidekick.config")
local Util = require("sidekick.util")

---@class sidekick.cli.muxer.Cmux: sidekick.cli.Session
---@field cmux_surface_id string
---@field cmux_workspace_id string?
local M = {}
M.__index = M

-- Known sessions keyed by surface ref
---@type table<string, sidekick.cli.session.State>
M._sessions = {}

function M:init()
  if self.started then
    self.external = true
  else
    self.external = vim.env.CMUX_SURFACE_ID ~= nil and Config.cli.mux.create ~= "terminal"
  end
  self.priority = self.external and 10 or 50
end

---@return sidekick.cli.terminal.Cmd?
function M:attach()
  self:focus_surface()
end

--- Focus the surface if using window (tab) mode.
function M:focus_surface()
  if not self.cmux_surface_id then
    return
  end
  if (Config.cli.mux.create or "split") ~= "split" then
    M._socket_request("surface.focus", { surface_id = self.cmux_surface_id })
  end
end

--- Surface + workspace params for socket calls.
---@return table
function M:_surface_params()
  return { surface_id = self.cmux_surface_id, workspace_id = self.cmux_workspace_id }
end

---@return sidekick.cli.terminal.Cmd?
function M:start()
  if not self.external then
    return { cmd = self.tool.cmd, env = self.tool.env }
  end

  local create = Config.cli.mux.create or "split"
  local ws = vim.env.CMUX_WORKSPACE_ID
  local result, label

  if create == "split" then
    local direction = Config.cli.mux.split and Config.cli.mux.split.vertical and "right" or "down"
    result = M._socket_request_sync("surface.split", {
      direction = direction,
      workspace_id = ws,
    })
    label = "cmux split"
  else
    result = M._socket_request_sync("surface.create", {
      workspace_id = ws,
    })
    label = "cmux tab"
  end

  if result and result.surface_ref then
    self.cmux_surface_id = result.surface_ref
    self.cmux_workspace_id = ws
    self.started = true

    local tool_cmd = table.concat(self.tool.cmd, " ")
    M._socket_request_sync("surface.send_text", {
      surface_id = result.surface_ref,
      workspace_id = ws,
      text = tool_cmd .. "\n",
    })

    M._sessions[result.surface_ref] = {
      id = "cmux:" .. result.surface_ref,
      cwd = self.cwd,
      tool = self.tool,
      cmux_surface_id = result.surface_ref,
      cmux_workspace_id = ws,
      started = true,
    }

    self:focus_surface()
    Util.info(("Started **%s** in a new %s"):format(self.tool.name, label))
  end
end

-- Cached set of live surface refs per workspace, refreshed once per event loop cycle.
M._live_cache = nil
M._live_cache_tick = -1

--- Get live surface refs for a workspace (cached per tick).
---@param workspace_id string
---@return table<string, boolean>
function M._get_live_surfaces(workspace_id)
  local tick = vim.uv.now()
  if not M._live_cache or tick ~= M._live_cache_tick then
    M._live_cache = {}
    M._live_cache_tick = tick
  end
  if M._live_cache[workspace_id] then
    return M._live_cache[workspace_id]
  end
  local surfaces = {}
  local result = M._socket_request_sync("surface.list", { workspace_id = workspace_id })
  if result and result.surfaces then
    for _, s in ipairs(result.surfaces) do
      if s.ref then
        surfaces[s.ref] = true
      end
    end
  end
  M._live_cache[workspace_id] = surfaces
  return surfaces
end

function M:is_running()
  if not self.cmux_surface_id or not self.cmux_workspace_id then
    return false
  end
  if M._get_live_surfaces(self.cmux_workspace_id)[self.cmux_surface_id] then
    return true
  end
  M._sessions[self.cmux_surface_id] = nil
  return false
end

function M:send(text)
  if not self.cmux_surface_id then
    return
  end
  -- Strip trailing newline — cmux treats \n as enter, but
  -- sidekick appends \n to all send() calls. Submit is handled separately.
  text = text:gsub("\n+$", "")
  M._socket_request("surface.send_text", vim.tbl_extend("force", self:_surface_params(), { text = text }))
  self:focus_surface()
end

function M:submit()
  if not self.cmux_surface_id then
    return
  end
  M._socket_request("surface.send_key", vim.tbl_extend("force", self:_surface_params(), { key = "enter" }))
end

function M:dump()
  if not self.cmux_surface_id then
    return
  end
  local result = M._socket_request_sync("surface.read_text", self:_surface_params())
  if not result then
    M._sessions[self.cmux_surface_id] = nil
    return
  end
  return result.text
end

-- Socket communication -------------------------------------------------------

--- Resolve the cmux Unix socket path.
---@return string?
function M._socket_path()
  local paths = {
    vim.env.CMUX_SOCKET_PATH,
    vim.fs.normalize("~/Library/Application Support/cmux/cmux.sock"),
    "/tmp/cmux.sock",
  }
  for _, p in ipairs(paths) do
    if p and vim.uv.fs_stat(p) then
      return p
    end
  end
end

--- Send a fire-and-forget JSON-RPC request to the cmux socket via libuv.
---@param method string
---@param params table
function M._socket_request(method, params)
  local path = M._socket_path()
  if not path then
    return
  end
  local pipe = vim.uv.new_pipe()
  pipe:connect(path, function(err)
    if err then
      pipe:close()
      return
    end
    local msg = vim.json.encode({ id = "sk", method = method, params = params }) .. "\n"
    pipe:write(msg, function()
      pipe:close()
    end)
  end)
end

--- Send a synchronous JSON-RPC request to the cmux socket.
--- Uses neovim's built-in sockconnect/chansend.
--- Returns the parsed result table, or nil on error.
---@param method string
---@param params table
---@return table?
function M._socket_request_sync(method, params)
  local path = M._socket_path()
  if not path then
    return nil
  end
  local chunks = {}
  local channel = vim.fn.sockconnect("pipe", path, {
    on_data = function(_, data)
      for _, chunk in ipairs(data) do
        if chunk ~= "" then
          chunks[#chunks + 1] = chunk
        end
      end
    end,
  })
  if channel == 0 then
    return nil
  end
  local msg = vim.json.encode({ id = "sk", method = method, params = params }) .. "\n"
  vim.fn.chansend(channel, msg)
  -- Wait until we have a complete JSON response (ends with newline)
  vim.wait(2000, function()
    if #chunks == 0 then
      return false
    end
    local last = chunks[#chunks]
    return last:sub(-1) == "\n" or last:sub(-1) == "}"
  end, 5)
  vim.fn.chanclose(channel)

  local response = table.concat(chunks, "")
  if response == "" then
    return nil
  end
  local ok, decoded = pcall(vim.json.decode, response)
  if ok and decoded and decoded.ok then
    return decoded.result
  end
  return nil
end

-- Session discovery -----------------------------------------------------------

--- Discover running tool sessions in the active workspace.
--- Uses socket (system.tree) for surface/TTY data, then ps -t for PID mapping.
function M.sessions()
  local ret = {} ---@type sidekick.cli.session.State[]
  local seen = {} ---@type table<string, boolean>

  local surfaces = M._parse_tree()
  if vim.tbl_isempty(surfaces) then
    return ret
  end

  local tools = Config.tools()
  local Procs = require("sidekick.cli.procs")
  local procs = Procs.new()

  -- Build TTY→surface lookup, resolve all TTY→PID in one ps call
  local tty_to_surface = {}
  for _, surface in ipairs(surfaces) do
    tty_to_surface[surface.tty] = surface
  end
  local tty_pids = M._all_tty_pids(tty_to_surface)

  for tty, pid in pairs(tty_pids) do
    local surface = tty_to_surface[tty]
    procs:walk(pid, function(proc)
      for _, tool in pairs(tools) do
        if tool:is_proc(proc) then
          local state = {
            id = "cmux:" .. surface.ref,
            cwd = "",
            tool = tool,
            cmux_surface_id = surface.ref,
            cmux_workspace_id = surface.workspace,
            started = true,
          }
          ret[#ret + 1] = state
          seen[surface.ref] = true
          M._sessions[surface.ref] = state
          return true
        end
      end
    end)
  end

  -- Prune tracked sessions whose surfaces are gone
  for ref in pairs(M._sessions) do
    if not seen[ref] then
      M._sessions[ref] = nil
    end
  end

  return ret
end

--- Get terminal surfaces in the active workspace via the cmux socket.
---@return {ref:string, tty:string, workspace:string}[]
function M._parse_tree()
  local data = M._socket_request_sync("system.tree", {})
  if not data or not data.active or not data.windows then
    return {}
  end
  local active_ws = data.active.workspace_ref
  local surfaces = {}
  for _, window in ipairs(data.windows) do
    for _, workspace in ipairs(window.workspaces or {}) do
      if workspace.ref == active_ws then
        for _, pane in ipairs(workspace.panes or {}) do
          for _, surface in ipairs(pane.surfaces or {}) do
            if surface.type == "terminal" and surface.tty then
              surfaces[#surfaces + 1] = {
                ref = surface.ref,
                tty = surface.tty,
                workspace = active_ws,
              }
            end
          end
        end
      end
    end
  end
  return surfaces
end

--- Resolve TTY→root PID for all given TTYs in a single ps call.
---@param tty_set table<string, any> keys are TTY names (e.g. "ttys009")
---@return table<string, number> tty→pid
function M._all_tty_pids(tty_set)
  local ttys = vim.tbl_keys(tty_set)
  if #ttys == 0 then
    return {}
  end
  -- ps -t fails if any TTY device doesn't exist, so filter first
  local valid = {}
  for _, tty in ipairs(ttys) do
    if vim.uv.fs_stat("/dev/" .. tty) then
      valid[#valid + 1] = tty
    end
  end
  if #valid == 0 then
    return {}
  end
  local ret = {}
  local lines = Util.exec({ "ps", "-t", table.concat(valid, ","), "-o", "pid,tty" }, { notify = false })
  for _, line in ipairs(lines or {}) do
    local pid, tty = line:match("^%s*(%d+)%s+(%S+)")
    if pid and tty and tty_set[tty] and not ret[tty] then
      ret[tty] = tonumber(pid)
    end
  end
  return ret
end

--- Register the backend and patch sidekick for cmux support.
function M.register()
  require("sidekick.cli.session").register("cmux", M)

  -- Patch State.attach to focus cmux surfaces.
  -- Session.attach skips backend attach() for already-attached sessions,
  -- but State.attach runs on every toggle/select — so we hook here.
  local State = require("sidekick.cli.state")
  local orig_attach = State.attach
  State.attach = function(state, opts)
    local ret, attached = orig_attach(state, opts)
    if ret.session and ret.session.focus_surface then
      ret.session:focus_surface()
    end
    return ret, attached
  end
end

return M
