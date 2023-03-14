return {
  "L3MON4D3/LuaSnip",
  name = "luasnip",
  -- follow latest release.
  version = "1.*",
  -- install jsregexp (optional!).
  -- build = "make install_jsregexp"
  dependencies = {
    "rafamadriz/friendly-snippets", -- a bunch of snippets to use
    "benfowler/telescope-luasnip.nvim", -- telescope plugin for luasnip
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
