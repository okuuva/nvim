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

local function toggle_narrow_zen()
  Snacks.zen({ win = { style = "narrow_zen" } })
end

return {
  -- "folke/snacks.nvim",
  -- version = "^2.0.0",
  -- TODO: switch back to stable / main once PR gets merged
  -- https://github.com/folke/snacks.nvim/pull/447
  "okuuva/snacks.nvim",
  branch = "use-foldcolumn-hlgroup",
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
      preset = {
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "t", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "e", desc = "Edit Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = "󰜺 ", key = "c", desc = "Close Dashboard", action = ":lua Snacks.bufdelete()" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
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
      top_down = false,
    },
    notify = { enabled = true },
    scope = { enabled = true },
    scroll = {
      animate = {
        duration = { step = 25, total = 250 },
        easing = "inOutQuad",
      },
    },
    statuscolumn = {
      left = {},
      folds = {
        open = true, -- show open fold icons
        git_hl = false, -- do use Git Signs hl for fold icons
      },
    },
    quickfile = { enabled = true },
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
      ---@diagnostic disable-next-line: missing-fields
      lazygit = {
        height = 0,
        width = 0,
      },
      ---@diagnostic disable-next-line: missing-fields
      zen = {
        -- FIXME: figure out how to use theme here instead of hardcoded value
        backdrop = {
          bg = "#212121",
          transparent = false,
        },
      },
      ---@diagnostic disable-next-line: missing-fields
      narrow_zen = {
        style = "zen",
        width = 80,
      },
    },
  },
}
