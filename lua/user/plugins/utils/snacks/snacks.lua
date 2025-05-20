---@type LazyPluginSpec
return {
  "folke/snacks.nvim",
  version = "^2.0.0",
  priority = 1000,
  lazy = false,
  dependencies = {
    "mini.icons",
    "nvim-web-devicons",
  },
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dim = { enabled = true },
    image = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = {
      animate = {
        duration = { step = 25, total = 250 },
        easing = "inOutQuad",
        fps = 60,
      },
    },
  },
}
