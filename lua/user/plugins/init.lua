return {
  "folke/lazy.nvim",
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
  { import = "user.plugins.helpers" },

  -- LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig", -- enable LSP
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- cool virtual line diagnostics
  "folke/neodev.nvim", -- easier config / plugin development
  "b0o/schemastore.nvim", -- json schemas for jsonls
  "ray-x/lsp_signature.nvim", -- function signatures as I type
  "smjonas/inc-rename.nvim", -- really fancy renamer

  { import = "user.plugins.syntax-highlighting" },
}
