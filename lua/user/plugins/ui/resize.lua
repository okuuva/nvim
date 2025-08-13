---@type LazyPluginSpec
return {
  "0xm4n/resize.nvim",
  version = "*",
  event = "VeryLazy",
  -- stylua: ignore
  keys = {
    { "<S-Left>", "<cmd>lua require('resize').ResizeLeft()<CR>", mode = "n", desc = "Resize left" },
    { "<S-Right>", "<cmd>lua require('resize').ResizeRight()<CR>", mode = "n", desc = "Resize right" },
    { "<S-Up>", "<cmd>lua require('resize').ResizeUp()<CR>", mode = "n", desc = "Resize up" },
    { "<S-Down>", "<cmd>lua require('resize').ResizeDown()<CR>", mode = "n", desc = "Resize down" },
  },
  opts = {},
}
