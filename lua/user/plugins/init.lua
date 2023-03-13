return {
  { import = "user.plugins.colorschemes" },
  "folke/lazy.nvim",
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  },
  "sitiom/nvim-numbertoggle",
  "nvim-orgmode/orgmode",
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
  },
  {
    "windwp/nvim-spectre",
    config = true,
  },
  {
    "mcauley-penney/tidy.nvim",
    config = true,
    event = "BufWritePre",
  },

  -- Legacy plugins (replace with equivalent Lua plugins whenever available)
  "felipec/vim-sanegx",
  "mechatroner/rainbow_csv",
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },

  { import = "user.plugins.debuggers" },
  { import = "user.plugins.autocomplete" },

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

  -- Non-LSP syntaxt plugins
  "raimon49/requirements.txt.vim",
  "towolf/vim-helm",
  "fladson/vim-kitty",

  -- Telescope
  { import = "user.plugins.telescope" },
  "benfowler/telescope-luasnip.nvim", -- telescope plugin for luasnip

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "JoosepAlviste/nvim-ts-context-commentstring",
  "folke/twilight.nvim",
  "windwp/nvim-ts-autotag",
  "nvim-treesitter/nvim-treesitter-context",
  "theHamsta/nvim-dap-virtual-text",
  "andymass/vim-matchup",
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-refactor",
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  "numToStr/Comment.nvim", -- Easily comment stuff
  "nvim-treesitter/nvim-tree-docs",

  { import = "user.plugins.ui" },
  { import = "user.plugins.git" },
  { import = "user.plugins.session-management" },
  -- "pwntester/octo.nvim",

  -- IDE-like stuff
  "hkupty/iron.nvim",
}
