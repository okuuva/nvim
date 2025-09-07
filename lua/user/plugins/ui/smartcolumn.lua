return {
  "m4xshen/smartcolumn.nvim",
  event = "BufEnter",
  opts = {
    colorcolumn = "110",
    disabled_filetypes = {
      "lazy",
      "alpha",
      "checkhealth",
      "harpoon",
      "help",
      "markdown",
      "mason",
      "neo-tree",
      "noice",
      "snacks_dashboard",
      "snacks_notif_history",
      "text",
      "trouble",
    },
    custom_colorcolumn = {
      python = "110",
      lua = "120",
      gitcommit = "72",
      jjdescription = "72",
    },
    scope = "window", -- file (default), window, line
  },
}
