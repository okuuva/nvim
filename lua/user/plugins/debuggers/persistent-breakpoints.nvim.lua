---@type LazyPluginSpec
return {
  "Weissle/persistent-breakpoints.nvim",
  event = "BufReadPre",
  opts = {
    load_breakpoints_event = { "BufReadPost" },
  },
}
