return {
  "folke/twilight.nvim",
  cmd = {
    "Twilight",
    "TwilightEnable",
    "TwilightDisable",
  },
  keys = {
    { "<leader>Tt", "<cmd>Twilight<CR>", desc = "Toggle Twilight" },
  },
  dependencies = { "nvim-treesitter" },
  opts = {
    -- expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    --   "function",
    --   "function_definition",
    --   "method",
    --   "method_definition",
    --   "if_statement",
    --   "try_statement",
    --   "except_clause",
    --   "table",
    --   "dictionary",
    -- },
    exclude = { "gitcommit" }, -- exclude these filetypes
  },
}
