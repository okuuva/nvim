return {
  "gbprod/yanky.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  keys = {
    { "p", "<Plug>(YankyPutAfter)", desc = "Put After", mode = { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", desc = "Put Before", mode = { "n", "x" } },
    { "gp", "<Plug>(YankyGPutAfter)", desc = "Put After", mode = { "n", "x" } },
    { "gP", "<Plug>(YankyGPutBefore)", desc = "Put Before", mode = { "n", "x" } },
    { "<c-k>", "<Plug>(YankyCycleForward)", desc = "Cycle Yanky Ring Forward" },
    { "<c-j>", "<Plug>(YankyCycleBackward)", desc = "Cycle Yanky Ring Backward" },
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
      telescope = {
        mappings = nil, -- nil to use default mappings
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
