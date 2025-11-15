---@type LazyPluginSpec
return {
  "pmizio/typescript-tools.nvim",
  ft = { "typescript", "typescriptreact" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
    "lbrayner/vim-rzip",
  },
  opts = {
    settings = {
      expose_as_code_action = "all",
      tsserver_format_options = function(_)
        local values = {
          indentSize = vim.bo.shiftwidth,
          tabSize = vim.bo.tabstop,
          convertTabsToSpaces = vim.bo.expandtab,
          trimTrailingWhitespace = type(vim.b.editorconfig) == "table"
              and (vim.b.editorconfig.trim_trailing_whitespace == "true")
            or false,
        }
        return values
      end,
    },
  },
}
