return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<leader>Tl", "<cmd>TSInstallInfo<cr>", desc = "List installed parsers" },
    { "<leader>Tp", "<cmd>TSPlaygroundToggle<cr>", desc = "Toggle Playground" },
    { "<leader>Th", "<cmd>TSHighlightCapturesUnderCursor<cr>", desc = "Show highlight capture groups under cursor" },
  },
  dependencies = {
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-refactor",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    "andymass/vim-matchup",
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = {
        -- mandatory parsers
        "c",
        "lua",
        "query",
        "vim",
        "vimdoc",
        -- usual suspects
        "diff",
        "dockerfile",
        "fish",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "jq",
        "json",
        "org",
        "python",
        "rst",
        "sql",
        "toml",
        "yaml",
        -- noice dependencies
        "bash",
        "markdown",
        "markdown_inline",
        "regex",
        -- neoconf dependency
        "jsonc",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      -- List of parsers to ignore installing (or "all")
      ignore_install = { "" },

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
            smart_rename = "gr",
          },
        },
      },
    })
  end,
}
