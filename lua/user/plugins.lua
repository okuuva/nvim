local api = vim.api
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that keeps installed plugins in sync whenever you save plugins.lua
api.nvim_create_autocmd("BufWritePost", {
  group = api.nvim_create_augroup("packer_augroup", {}),
  pattern = "plugins.lua",
  command = [[source <afile> | PackerSync]],
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  max_jobs = 64,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use("wbthomason/packer.nvim") -- Have packer manage itself
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("MunifTanjim/nui.nvim") -- UI library used by some plugins
  use("stevearc/dressing.nvim") -- UI library used by some plugins
  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("numToStr/Comment.nvim") -- Easily comment stuff
  use("kyazdani42/nvim-web-devicons")
  use("kyazdani42/nvim-tree.lua")
  use("akinsho/bufferline.nvim")
  use("famiu/bufdelete.nvim")
  use("nvim-lualine/lualine.nvim")
  use("ahmedkhalf/project.nvim")
  use("lewis6991/impatient.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("goolord/alpha-nvim")
  use("folke/which-key.nvim")
  use("folke/trouble.nvim")
  use("tversteeg/registers.nvim")
  use("ggandor/leap.nvim")
  use("folke/todo-comments.nvim")
  use("karb94/neoscroll.nvim")
  use("rcarriga/nvim-notify")
  use("AckslD/messages.nvim")
  use("rktjmp/paperplanes.nvim")
  use("sitiom/nvim-numbertoggle")
  use("levouh/tint.nvim")
  use("luukvbaal/statuscol.nvim") -- nvim >= 0.9
  use({
    "windwp/nvim-spectre",
    config = function()
      require("spectre").setup()
    end,
  })
  use({
    "s1n7ax/nvim-window-picker",
    tag = "v1.*",
  })
  use({
    "mcauley-penney/tidy.nvim",
    config = function()
      require("tidy").setup()
    end,
  })

  -- Legacy plugins (replace with equivalent Lua plugins whenever available)
  use("felipec/vim-sanegx")

  -- Session management
  use("olimorris/persisted.nvim")
  -- plugins below aren't strictly session management but related anyway
  use("nvim-zh/auto-save.nvim")
  use("ethanholz/nvim-lastplace")

  -- Pretty(er) code folding
  use({
    "anuvyklack/fold-preview.nvim",
    requires = "anuvyklack/keymap-amend.nvim", -- only for preview
  })
  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

  -- Debugger
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("Weissle/persistent-breakpoints.nvim")

  -- Debugger language specific plugins
  use("mfussenegger/nvim-dap-python")
  use("jbyuki/one-small-step-for-vimkind") -- lua

  -- Colorschemes
  use("marko-cerovac/material.nvim")
  use("brenoprata10/nvim-highlight-colors") -- highlight hex colors

  -- cmp plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("KadoBOT/cmp-plugins") -- plugin to autocomplete plugins. compleception?
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("bydlw98/cmp-env")
  use({ "mtoohey31/cmp-fish", ft = "fish" })

  -- snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- LSP
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("neovim/nvim-lspconfig") -- enable LSP
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use("https://git.sr.ht/~whynothugo/lsp_lines.nvim") -- cool virtual line diagnostics
  use("folke/neodev.nvim") -- easier config / plugin development
  use("b0o/schemastore.nvim") -- json schemas for jsonls
  use("ray-x/lsp_signature.nvim") -- function signatures as I type
  use("smjonas/inc-rename.nvim") -- really fancy renamer
  use("WhoIsSethDaniel/lualine-lsp-progress")

  -- Non-LSP syntaxt plugins
  use("raimon49/requirements.txt.vim")
  use("towolf/vim-helm")
  use("fladson/vim-kitty")

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use("benfowler/telescope-luasnip.nvim") -- telescope plugin for luasnip
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("folke/twilight.nvim")
  use("windwp/nvim-ts-autotag")
  use("nvim-treesitter/nvim-treesitter-context")
  use("theHamsta/nvim-dap-virtual-text")
  use("andymass/vim-matchup")
  use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter-refactor")

  -- Git
  use("lewis6991/gitsigns.nvim")
  use("kdheepak/lazygit.nvim")
  use("sindrets/diffview.nvim")
  use("ruifm/gitlinker.nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
