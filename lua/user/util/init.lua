local M = {}

M.root_patterns = { ".git", ".jj", "lua" }

-- this is lifted straight from LazyVim:
-- https://github.com/LazyVim/LazyVim/blob/87c37f287b609f9fba12d2a6a518823d438bac44/lua/lazyvim/util/init.lua

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.uv.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.uv.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.uv.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.uv.cwd()
  end
  ---@cast root string
  return root
end

-- the following are my own additions
function M.reload_buffers()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local bufname = vim.api.nvim_buf_get_name(buf)
      if vim.fn.filereadable(bufname) == 1 then
        vim.api.nvim_buf_call(buf, function()
          vim.cmd("edit!")
        end)
      end
    end
  end
  vim.notify("Buffers reloaded")
end

---@param pattern string
---@param tbl table<any, string>
---@return boolean
function M.pattern_in_string_table(pattern, tbl)
  for _, str in ipairs(tbl) do
    if str:find(pattern) then
      return true
    end
  end
  return false
end

---@param str string
---@param tbl table<any, string>
---@return boolean
function M.string_in_pattern_table(str, tbl)
  for _, pattern in ipairs(tbl) do
    if str:find(pattern) then
      return true
    end
  end
  return false
end

local _path_blacklist = { "/work/", "/notes/" }

local function ai_is_path_blacklisted()
  local success, local_ai_config = pcall(require, "user.config.local.ai")
  local path_blacklist = success and local_ai_config.path_blacklist or _path_blacklist
  local path = M.get_root()
  return M.string_in_pattern_table(path, path_blacklist)
end

local _plugin_blacklist = { "supermaven-nvim" }

---@param plugin string | nil Check if passed plugin is allowed to load AI helpers
---@return boolean
local function ai_is_plugin_blacklisted(plugin)
  if plugin == nil then
    return false
  end

  local success, local_ai_config = pcall(require, "user.config.local.ai")
  local plugin_blacklist = success and local_ai_config.plugin_blacklist or _plugin_blacklist
  return M.string_in_pattern_table(plugin, plugin_blacklist)
end

---@param plugin? string Check if passed plugin is allowed to load AI helpers
---@return boolean
function M.ai_helpers_allowed(plugin)
  return not ai_is_plugin_blacklisted(plugin) and not ai_is_path_blacklisted()
end

---@param line string
---@return table<string>
function M.graphite_string_to_markdown_list(line)
  -- Remove the opening and closing blockquote tags
  line = line:gsub("<blockquote>", ""):gsub("</blockquote>", "")

  -- Split by <br /> tags
  local entries = vim.split(line, "<br />", { plain = true })

  local result = {}
  -- Process entries in reverse order
  for i = #entries, 1, -1 do
    local entry = entries[i]
    -- Match any leading emoji or text before the <a ...> part
    local url, text, code = entry:match('.- <a href="([^"]+)">([^<]+)</a> <code>([^<]+)</code>')
    if url and text and code then
      table.insert(result, string.format("- [%s](<%s>) `%s`", text, url, code))
    end
  end

  return result
end

--- Turn Graphite Share Stack output into a markdown list
function M.process_graphite_share_stack_string()
  local line = vim.api.nvim_get_current_line()
  local line_num = vim.api.nvim_win_get_cursor(0)[1] - 1

  local result = M.graphite_string_to_markdown_list(line)

  -- Delete the current line and insert the formatted results
  vim.api.nvim_buf_set_lines(0, line_num, line_num + 1, false, result)

  -- Also put the formatted results to the clipboard
  vim.fn.setreg("+", table.concat(result, "\n"))
  vim.notify("Copied to clipboard")
end

--- Utility to register multiple which-key groups safely
--- @param mappings wk.Spec
function M.wk_add(mappings)
  local ok, wk = pcall(require, "which-key")
  if not ok then
    return
  end
  wk.add(mappings)
end

M.markdown_filetypes = {
  "codesettings-output",
  "markdown",
  "octo",
}

M.vcs_filetypes = {
  "gitcommit",
  "gitrebase",
  "hgcommit",
  "jjdescription",
  "svn",
}

--- Extend the given list with all the given lists
--- Instead of modifying the given list, creates and returns a new list
--- @param list any[]
--- @param ... any[]
--- @return any[]
local function list_extend(list, ...)
  local ret = {}
  vim.list_extend(ret, list)
  for _, l in ipairs({ ... }) do
    vim.list_extend(ret, l)
  end
  return ret
end

--- Extend the given list with all the filetypes that should be treated as markdown
--- @param filetypes string[]
--- @return string[]
function M.include_markdown_filetypes(filetypes)
  return list_extend(M.markdown_filetypes, filetypes)
end

--- Extend the given list with all the filetypes that should be treated as vcs
--- @param filetypes string[]
--- @return string[]
function M.include_vcs_filetypes(filetypes)
  return list_extend(M.vcs_filetypes, filetypes)
end

--- Extend the given list with all the filetypes that should be treated as markdown
--- @param filetypes string[]
--- @return string[]
function M.include_md_and_vcs_filetypes(filetypes)
  return list_extend(M.markdown_filetypes, M.vcs_filetypes, filetypes)
end

return M
