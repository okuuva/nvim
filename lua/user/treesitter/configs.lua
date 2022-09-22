require("nvim-treesitter.configs").setup({
  ensure_installed = "all", -- "all", or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = { enable = true },
  autotag = { enable = true },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true },
  matchup = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
