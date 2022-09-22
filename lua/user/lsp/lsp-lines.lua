local status_ok, lsp_lines = pcall(require, "lsp_lines")
if not status_ok then
  return
end

lsp_lines.setup()

-- This is just an override, check handlers.lua for original settings
vim.diagnostic.config({
  virtual_lines = {
    only_current_line = true,
  }
})
