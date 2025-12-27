---@type LazyPluginSpec
return {
  "snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      sources = {
        colorschemes = {
          layout = "left",
        },
      },
    },
  },
  optional = true,
}
