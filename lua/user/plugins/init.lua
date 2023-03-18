return {
  {
    "folke/lazy.nvim",
    keys = {
      { "<leader>L", "<cmd>Lazy<cr>", desc = "Lazy" },
    },
  },
  { import = "user.plugins.colorschemes" },
  { import = "user.plugins.ide" },
  { import = "user.plugins.productivity" },
  { import = "user.plugins.debuggers" },
  { import = "user.plugins.autocomplete" },
  { import = "user.plugins.searching" },
  { import = "user.plugins.treesitter" },
  { import = "user.plugins.navigation" },
  { import = "user.plugins.ui" },
  { import = "user.plugins.git" },
  { import = "user.plugins.session-management" },
  { import = "user.plugins.utils" },
  { import = "user.plugins.lsp" },
  { import = "user.plugins.syntax-highlighting" },
}
