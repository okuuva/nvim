---@type vim.lsp.Config
return {
  ---@module "codesettings"
  ---@type lsp.ruff_lsp
  settings = {
    lint = {
      select = {
        "ALL",
      },
      ignore = {
        "D1", -- missing docstring
      },
    },
  },
}
