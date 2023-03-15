return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local null_ls = require("null-ls")

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
    local code_actions = null_ls.builtins.code_actions

    local darker = require("user.plugins.lsp.null-ls.custom.formatting.darker")

    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {

        -- Code actions
        code_actions.shellcheck,

        -- Diagnostics
        diagnostics.fish,

        -- Formatting
        formatting.black.with({
          cwd = function(params)
            return vim.fn.fnamemodify(params.bufname, ":h")
          end,
          condition = function(utils)
            return not utils.root_has_file(".darker")
          end,
          extra_args = { "--fast" },
        }),
        formatting.fish_indent,
        formatting.isort.with({
          condition = function(utils)
            return not utils.root_has_file(".darker")
          end,
        }),
        formatting.prettier,
        formatting.shfmt,
        formatting.stylua,

        darker.with({
          condition = function(utils)
            return utils.root_has_file(".darker")
          end,
        }),
      },
    }
  end,
}
