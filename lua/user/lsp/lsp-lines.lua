local status_ok, lsp_lines = pcall(require, "lsp_lines")
if not status_ok then
  return
end

lsp_lines.setup()

vim.diagnostic.config({
  virtual_text = false, -- Disable virtual_text since it's redundant due to lsp_lines.
  virtual_lines = true, -- Enable lsp_lines
})
