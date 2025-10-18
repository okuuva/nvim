---@type vim.lsp.Config
return {
  filetypes = { "ruby" },
  init_options = {
    allocationType = "tempdir",
    indexGems = false,
    reportDiagnostics = true,
  },
}
