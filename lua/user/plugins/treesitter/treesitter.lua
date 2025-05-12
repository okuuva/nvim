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
    {
      "andymass/vim-matchup",
      init = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
      opts = {},
    },
    -- NOTE: additional parser
    { "nushell/tree-sitter-nu", build = ":TSUpdate nu" },
  },
  config = function()
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
        -- render-markdown dependencies
        "latex",
        -- snacks.image dependencies
        "css",
        "html",
        "javascript",
        "latex",
        "norg",
        "scss",
        "svelte",
        "tsx",
        "typst",
        "vue",
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
            smart_rename = "gR",
          },
        },
      },
      -- textobjects = {
      -- select = {
      --   enable = true,
      --
      --   -- Automatically jump forward to textobj, similar to targets.vim
      --   lookahead = true,
      --
      --   keymaps = {
      --     -- You can use the capture groups defined in textobjects.scm
      --     ["af"] = "@function.outer",
      --     ["if"] = "@function.inner",
      --     ["ac"] = "@class.outer",
      --     -- You can optionally set descriptions to the mappings (used in the desc parameter of
      --     -- nvim_buf_set_keymap) which plugins like which-key display
      --     ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      --     -- You can also use captures from other query groups like `locals.scm`
      --     ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
      --   },
      --   -- You can choose the select mode (default is charwise 'v')
      --   --
      --   -- Can also be a function which gets passed a table with the keys
      --   -- * query_string: eg '@function.inner'
      --   -- * method: eg 'v' or 'o'
      --   -- and should return the mode ('v', 'V', or '<c-v>') or a table
      --   -- mapping query_strings to modes.
      --   selection_modes = {
      --     ["@parameter.outer"] = "v", -- charwise
      --     ["@function.outer"] = "V", -- linewise
      --     ["@class.outer"] = "<c-v>", -- blockwise
      --   },
      --   -- If you set this to `true` (default is `false`) then any textobject is
      --   -- extended to include preceding or succeeding whitespace. Succeeding
      --   -- whitespace has priority in order to act similarly to eg the built-in
      --   -- `ap`.
      --   --
      --   -- Can also be a function which gets passed a table with the keys
      --   -- * query_string: eg '@function.inner'
      --   -- * selection_mode: eg 'v'
      --   -- and should return true or false
      --   include_surrounding_whitespace = true,
      -- },
      -- },
    })
  end,
}
