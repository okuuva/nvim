return {
  { import = "user.plugins.colorschemes" },
  "folke/lazy.nvim",
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  },
  "nvim-orgmode/orgmode",
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
  },
  {
    "mcauley-penney/tidy.nvim",
    config = true,
    event = "BufWritePre",
  },

  -- Legacy plugins (replace with equivalent Lua plugins whenever available)
  "felipec/vim-sanegx",
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },

  { import = "user.plugins.debuggers" },
  { import = "user.plugins.autocomplete" },
  { import = "user.plugins.searching" },
  { import = "user.plugins.treesitter" },
  { import = "user.plugins.navigation" },
  { import = "user.plugins.ui" },
  { import = "user.plugins.git" },
  { import = "user.plugins.session-management" },

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
  -- "pwntester/octo.nvim",

}
