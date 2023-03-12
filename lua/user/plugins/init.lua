return {
  "folke/lazy.nvim",
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "MunifTanjim/nui.nvim", -- UI library used by some plugins
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  },
  "nvim-lualine/lualine.nvim",
  "ahmedkhalf/project.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "folke/noice.nvim",
  "folke/todo-comments.nvim",
  "folke/trouble.nvim",
  "folke/which-key.nvim",
  "tversteeg/registers.nvim",
  "ggandor/leap.nvim",
  "karb94/neoscroll.nvim",
  "rcarriga/nvim-notify",
  "AckslD/messages.nvim",
  "rktjmp/paperplanes.nvim",
  "sitiom/nvim-numbertoggle",
  "levouh/tint.nvim",
  "akinsho/toggleterm.nvim",
  "luukvbaal/statuscol.nvim", -- nvim >= 0.9
  "m4xshen/smartcolumn.nvim",
  "nvim-orgmode/orgmode",
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
  },
  {
    "windwp/nvim-spectre",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "v1.*",
  },
  {
    "mcauley-penney/tidy.nvim",
    config = function()
      require("tidy").setup()
    end,
  },

  -- Legacy plugins (replace with equivalent Lua plugins whenever available)
  "felipec/vim-sanegx",
  "mechatroner/rainbow_csv",
  "dstein64/vim-startuptime",

  -- Session management
  -- plugins below aren't strictly session management but related anyway
  "okuuva/auto-save.nvim",
  "ethanholz/nvim-lastplace",

  -- Pretty(er) code folding
  {
    "anuvyklack/fold-preview.nvim",
    dependencies = "anuvyklack/keymap-amend.nvim", -- only for preview
  },
  { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },

  -- Debugger
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "Weissle/persistent-breakpoints.nvim",

  -- Debugger language specific plugins
  "mfussenegger/nvim-dap-python",
  "jbyuki/one-small-step-for-vimkind", -- lua

  -- Colorschemes
  -- { "okuuva/material.nvim", branch = "hide-vert-split" },
  "brenoprata10/nvim-highlight-colors", -- highlight hex colors

  -- cmp plugins
  "hrsh7th/nvim-cmp", -- The completion plugin
  "KadoBOT/cmp-plugins", -- plugin to autocomplete plugins. compleception?
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "bydlw98/cmp-env",
  { "mtoohey31/cmp-fish", ft = "fish" },

  -- snippets
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

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
  "nvim-telescope/telescope.nvim",
  "benfowler/telescope-luasnip.nvim", -- telescope plugin for luasnip
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

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
  "nvim-treesitter/nvim-tree-docs",

  -- Git
  "lewis6991/gitsigns.nvim",
  "kdheepak/lazygit.nvim",
  "sindrets/diffview.nvim",
  "ruifm/gitlinker.nvim",
  "pwntester/octo.nvim",

  -- IDE-like stuff
  "hkupty/iron.nvim",
}
