return {
  "m4xshen/smartcolumn.nvim",
  event = "BufEnter",
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
      "noice",
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
