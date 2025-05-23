return {
  "gbprod/yanky.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  keys = {
    { "y", "<Plug>(YankyYank)", desc = "Yank text", mode = { "n", "x" } },
    { "p", "<Plug>(YankyPutAfter)", desc = "Put after cursor", mode = { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", desc = "Put before cursor", mode = { "n", "x" } },
    { "gp", "<Plug>(YankyGPutAfter)", desc = "Put after selection", mode = { "n", "x" } },
    { "gP", "<Plug>(YankyGPutBefore)", desc = "Put before selection", mode = { "n", "x" } },
    { "]P", "<Plug>(YankyPutIndentAfter)", desc = "Put indented after cursor", mode = { "n", "x" } },
    { "[P", "<Plug>(YankyPutIndentBefore)", desc = "Put indented before cursor", mode = { "n", "x" } },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
    { "<c-[>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
    { "<c-]>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
  },
  opts = {
    ring = {
      history_length = 100,
      storage = "sqlite",
      sync_with_numbered_registers = true,
      cancel_event = "update",
    },
    picker = {
      select = {
        action = nil, -- nil to use default put action
      },
    },
    system_clipboard = {
      sync_with_ring = true,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 500,
    },
    preserve_cursor_position = {
      enabled = true,
    },
  },
}
