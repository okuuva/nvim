return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  cmd = {
    "TSContext",
    "TSContext enable",
    "TSContext disable",
    "TSContext toggle",
  },
  keys = {
    { "<leader>TC", "<cmd>TSContext toggle<cr>", desc = "Toggle context" },
  },
  dependencies = "nvim-treesitter",
  opts = {
    multiwindow = true,
    multiline_threshold = 2,
  },
}
