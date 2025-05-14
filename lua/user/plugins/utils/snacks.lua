local function BdeleteAndCloseTabIfNotLast()
  Snacks.bufdelete({ force = true })

  local tabpages = vim.api.nvim_list_tabpages()
  -- close tab if it's not the last one
  if #tabpages > 1 then
    vim.cmd("tabclose")
  end
end

local function create_lsp_progress_autocmd()
  ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
  local progress = vim.defaulttable()
  vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
      if not client or type(value) ~= "table" then
        return
      end
      local p = progress[client.id]

      for i = 1, #p + 1 do
        if i == #p + 1 or p[i].token == ev.data.params.token then
          p[i] = {
            token = ev.data.params.token,
            msg = ("[%3d%%] %s%s"):format(
              value.kind == "end" and 100 or value.percentage or 100,
              value.title or "",
              value.message and (" **%s**"):format(value.message) or ""
            ),
            done = value.kind == "end",
          }
          break
        end
      end

      local msg = {} ---@type string[]
      progress[client.id] = vim.tbl_filter(function(v)
        return table.insert(msg, v.msg) or not v.done
      end, p)

      local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      vim.notify(table.concat(msg, "\n"), "info", {
        id = "lsp_progress",
        title = client.name,
        opts = function(notif)
          notif.icon = #progress[client.id] == 0 and " "
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })
end

--Toggle narrow zen mode for the open buffer
_G.toggle_narrow_zen = function()
  Snacks.zen({ win = { style = "narrow_zen" } })
end

return {
  "folke/snacks.nvim",
  version = "^2.0.0",
  priority = 1000,
  lazy = false,
  dependencies = {
    "mini.icons",
    "nvim-web-devicons",
  },
  init = create_lsp_progress_autocmd(),
  -- stylua: ignore
  keys = {
    { "<leader>D",  function() Snacks.dashboard() end,               desc = "Dashboard" },
    { "<leader>c",  BdeleteAndCloseTabIfNotLast,                     desc = "Close Buffer" },
    { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse", mode = { "n", "x" } },
    { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
    { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
    { "<leader>nd", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
    { "<leader>nh", function() Snacks.notifier.show_history() end,   desc = "Notification History" },
    { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
    { "<leader>sb", function() Snacks.scratch.select() end,          desc = "Scratch Buffers" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    { "<leader>zm", function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
    { "<leader>zn", toggle_narrow_zen,                               desc = "Toggle Zen Mode (Narrow)" },
  },
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    -- TODO: figure out how to hide cursor on dashboard
    -- it was visible on alpha as well but would be cool to hide it
    -- see:
    -- - https://github.com/goolord/alpha-nvim/discussions/75
    -- - https://github.com/goolord/alpha-nvim/issues/208
    -- - https://github.com/neovim/neovim/issues/3688#issuecomment-574544618
    dashboard = {
      enabled = not USING_PAGE,
      preset = {
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "t", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "e", desc = "Edit Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
          { icon = " ", key = "w", desc = "List Git Worktrees", action = ":lua require('telescope').extensions.git_worktree.git_worktrees()" },
          { icon = " ", key = "W", desc = "Create Git Worktree", action = ":lua require('telescope').extensions.git_worktree.create_git_worktree()" },
          { icon = " ", key = "s", desc = "Restore Session", action = ":SessionSelect" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = "󰜺 ", key = "c", desc = "Close Dashboard", action = ":lua Snacks.bufdelete()" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    dim = { enabled = true },
    image = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    ---@class snacks.lazygit.Config: snacks.terminal.Opts
    lazygit = {
      -- automatically configure lazygit to use the current colorscheme
      -- and integrate edit with the current neovim instance
      configure = true,
      -- extra configuration for lazygit that will be merged with the default
      -- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
      -- you need to double quote it: `"\"test\""`
      config = {
        os = {
          editPreset = "nvim-remote",
        },
      },
    },
    notifier = {
      timeout = 6000,
      top_down = false,
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scratch = { enabled = true },
    scroll = {
      animate = {
        duration = { step = 25, total = 250 },
        easing = "inOutQuad",
        fps = 60,
      },
    },
    words = { enabled = true },
    zen = {
      -- see https://github.com/b0o/incline.nvim/discussions/77 for enabling incline for zen mode window
      -- callback where you can add custom code when the Zen window opens
      on_open = function()
        local status_ok, incline = pcall(require, "incline")
        if status_ok then
          incline.disable()
        end
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
        local status_ok, incline = pcall(require, "incline")
        if status_ok then
          incline.enable()
        end
      end,
    },

    styles = {
      lazygit = {
        height = 0,
        width = 0,
      },
      notification = {
        wo = {
          wrap = true,
        },
      },
      notification_history = {
        height = 0,
        width = 0,
        wo = {
          wrap = true,
        },
      },
      zen = {
        backdrop = {
          transparent = false,
          win = {
            -- TODO: find out why the backdrop group is named SnacksBackdrop_<color code> by default
            wo = { winhighlight = "Normal:SnacksBackdrop" },
          },
        },
      },
      narrow_zen = {
        style = "zen",
        width = 80,
      },
    },
  },
}
