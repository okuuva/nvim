return {
  "m4xshen/smartcolumn.nvim",
  opts = {
    colorcolumn = "110",
    disabled_filetypes = {
      "Lazy",
      "alpha",
      "checkhealth",
      "help",
      "markdown",
      "mason",
      "neo-tree",
      "text",
    },
    custom_colorcolumn = {
      python = "110",
      lua = "120",
      gitcommit = "72",
    },
    scope = "window", -- file (default), window, line
  },
}
