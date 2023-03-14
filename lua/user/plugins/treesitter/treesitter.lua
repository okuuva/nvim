local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  dependencies = {
    "nvim-treesitter-context",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-refactor",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
    "andymass/vim-matchup",
  },
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      -- usual suspects
      "diff",
      "dockerfile",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "fish",
      "jq",
      "json",
      "python",
      "rst",
      "sql",
      "toml",
      "yaml",
      -- noice dependencies
      "vim",
      "regex",
      "lua",
      "bash",
      "markdown",
      "markdown_inline",
    }, -- "all", or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "" }, -- List of parsers to ignore installing
    autopairs = { enable = true },
    autotag = { enable = true },
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "help" }, -- list of language that will be disabled
      additional_vim_regex_highlighting = true,
    },
    indent = {
      enable = true,
      disable = {
        "lua",
        "python",
        "yaml",
      },
    },
    matchup = { enable = true },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    refactor = {
      highlight_definitions = {
        enable = true,
        -- Set to false if you have an `updatetime` of ~100.
        clear_on_cursor_move = true,
      },
      smart_rename = {
        enable = true,
        keymaps = {
          -- smart_rename = "<leader>r",
          smart_rename = "gr",
        },
      },
    },
  })
end

return M
