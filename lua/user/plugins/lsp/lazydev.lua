---@type LazyPluginSpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  cond = true,
  opts = {
    library = {
      { path = "${3rd}/busted/library", words = { "describe%(" } },
      { path = "${3rd}/luassert/library", words = { "assert%." } },
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
      { path = "lazy.nvim", words = { "opts", "config" } },
    },
  },
}
