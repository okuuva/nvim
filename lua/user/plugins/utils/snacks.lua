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
    { "<leader>c",  BdeleteAndCloseTabIfNotLast,                     desc = "Close Buffer" },
    { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse", mode = { "n", "x" } },
    { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
    { "<leader>nd", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
    { "<leader>nh", function() Snacks.notifier.show_history() end,   desc = "Notification History" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
  },
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
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
    ---@field animate snacks.animate.Config
    scroll = {
      animate = {
        duration = { step = 25, total = 250 },
        easing = "inOutQuad",
      },
    },
    quickfile = { enabled = true },
    words = { enabled = true },
    ---@type table<string, snacks.win.Config>
    styles = {
      lazygit = {
        height = 0,
        width = 0,
      },
    },
  },
}
