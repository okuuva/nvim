---@type vim.lsp.Config
return {
  ---@module "codesettings"
  ---@type lsp.basedpyright
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = "workspace",
        diagnosticSeverityOverrides = {
          reportUnusedImport = "none", -- handled by ruff
        },
      },
      disableOrganizeImports = true, -- handled by ruff
      typeCheckingMode = "standard",
    },
    python = {
      analysis = {
        ignore = {
          "*", -- analysis is handled by ruff
        },
      },
      pythonPath = "./.venv/bin/python",
    },
  },
}
