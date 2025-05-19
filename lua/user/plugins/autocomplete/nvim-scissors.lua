---@type LazyPluginSpec
return {
  "chrisgrieser/nvim-scissors",
  dependencies = "telescope.nvim", -- if using telescope
  cmd = {
    "ScissorsAddNewSnippet",
    "ScissorsEditSnippet",
  },
  opts = {},
}
