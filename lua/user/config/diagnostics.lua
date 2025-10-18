---@class vim.diagnostic.Opts
local diagnostics_opts = {
  underline = true,
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  float = {
    source = true,
    border = "rounded",
  },
  severity_sort = true,
}

vim.diagnostic.config(diagnostics_opts)
