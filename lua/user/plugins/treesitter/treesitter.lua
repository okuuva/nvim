---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  cond = function()
    return not require("user.util.host").is_spike()
  end,
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
  -- registers mise files so that the injector can add syntax highlighting for embedded code blocks
  -- see https://mise.jdx.dev/mise-cookbook/neovim.html#code-highlight-for-run-commands
  init = function()
    require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
      local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
      local filename = vim.fn.fnamemodify(filepath, ":t")
      local first_line = vim.api.nvim_buf_get_lines(tonumber(bufnr) or 0, 0, 1, false)[1] or ""
      return string.match(filename, ".*mise.*%.toml$") ~= nil or string.match(first_line, "mise") ~= nil
    end, { force = true, all = false })
  end,
  config = function()
    -- In Neovim 0.12, vim.treesitter.start() is only called by default for
    -- lua, markdown, help, and query. Enable it for all filetypes that have
    -- an installed parser.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if not vim.b[args.buf].ts_highlight then
          pcall(vim.treesitter.start, args.buf)
        end
      end,
    })

    require("nvim-treesitter").setup({
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
        "norg",
        "scss",
        "svelte",
        "tsx",
        "typst",
        "vue",
        -- custom parsers
        "jjdescription",
      },
      auto_install = true,
    })
  end,
}
