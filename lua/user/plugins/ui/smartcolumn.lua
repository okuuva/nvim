return {
  "m4xshen/smartcolumn.nvim",
  event = "BufEnter",
  opts = {
    colorcolumn = "100",
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
      gitcommit = "72",
      jjdescription = "72",
    },
    scope = "window", -- file (default), window, line
    editorconfig = true,
  },
}
