return {
  "folke/neoconf.nvim",
  cmd = "Neoconf",
  keys = {
    { "<leader>NN", "<cmd>Neoconf<cr>", desc = "Edit local or global config" },
    { "<leader>NO", "<cmd>Neoconf local<cr>", desc = "Edit local config" },
    { "<leader>NG", "<cmd>Neoconf global<cr>", desc = "Edit global config" },
    { "<leader>NS", "<cmd>Neoconf show<cr>", desc = "Show merged config" },
    { "<leader>NL", "<cmd>Neoconf lsp<cr>", desc = "Show merged LSP config" },
    { "<leader>NC", "<cmd>Neoconf checkhealth<cr>", desc = "Check health" },
  },
  opts = {},
}
