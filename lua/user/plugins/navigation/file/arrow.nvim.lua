---@type LazyPluginSpec
return {
  "otavioschwanck/arrow.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-mini/mini.icons" },
  },
  keys = {
    { "<BS>", "<cmd>Arrow<cr>", desc = "Arrow" },
  },
  opts = {
    show_icons = true,
    leader_key = "<BS>", -- Recommended to be a single key
    buffer_leader_key = "m", -- Per Buffer Mappings
    mappings = {
      toggle = "0",
    },
  },
}
