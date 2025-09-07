---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  -- branch = "main",
  build = ":TSUpdate",
  lazy = false,
  keys = {
    { "<leader>TI", "<cmd>Inspect<cr>", desc = "Inspect current node" },
    { "<leader>TT", "<cmd>InspectTree<cr>", desc = "Toggle Tree browser" },
  },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
    },
    "windwp/nvim-ts-autotag",
    "RRethy/nvim-treesitter-endwise",
    {
      "andymass/vim-matchup",
      init = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
      opts = {},
    },
  },
  -- registers mise files so that the injector can add syntaxt highlighting for embedded code blocks
  -- see https://mise.jdx.dev/mise-cookbook/neovim.html#code-highlight-for-run-commands
  init = function()
    require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
      local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
      local filename = vim.fn.fnamemodify(filepath, ":t")
      local first_line = vim.api.nvim_buf_get_lines(tonumber(bufnr) or 0, 0, 1, false)[1] or ""
      return string.match(filename, ".*mise.*%.toml$") ~= nil or string.match(first_line, "mise") ~= nil
    end, { force = true, all = false })
    -- add the jjdescription parser
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.jjdescription = {
      install_info = {
        url = "https://github.com/kareigu/tree-sitter-jjdescription",
        files = { "src/parser.c" },
        branch = "dev",
        generate_requires_npm = false, -- Try setting this to false
        requires_generate_from_grammar = false, -- Try setting this to false
      },
    }
  end,
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
        "kdl",
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
