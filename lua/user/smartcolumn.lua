require("smartcolumn").setup({
  colorcolumn = 80,
  disabled_filetypes = { "help", "text", "markdown", "checkhealth" },
  custom_colorcolumn = {
    python = 110,
    lua = 120,
    gitcommit = 72,
  },
  limit_to_window = true,
  limit_to_line = false,
})
