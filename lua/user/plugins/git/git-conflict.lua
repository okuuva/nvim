---@type LazyPluginSpec
return {
  "akinsho/git-conflict.nvim",
  version = "v2.*",
  event = "VeryLazy",
  opts = {
    disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
  },
}
