return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "^1.2.1",
  -- install jsregexp (optional!).
  -- build = "make install_jsregexp"
  dependencies = {
    "rafamadriz/friendly-snippets",
    "benfowler/telescope-luasnip.nvim", -- telescope plugin for luasnip
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
  config = function(_, opts)
    require("luasnip").setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
