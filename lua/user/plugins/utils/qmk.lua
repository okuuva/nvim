---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "codethread/qmk.nvim",
      event = {
        "BufEnter *keymap.c",
        "BufEnter *.keymap",
      },
      opts = {
        auto_format_pattern = { "*keymap.c", "*.keymap" },
        -- these values are mandatory for the initial setup even if they're never used because the get overridden by
        -- inline JSON
        name = "placeholder",
        layout = {
          "x x x x x x _ _ _ x x x x x x",
          "x x x x x x _ _ _ x x x x x x",
          "x x x x x x _ _ _ x x x x x x",
          "_ _ _ _ x x x _ x x x _ _ _ _",
        },
        variant = "zmk",
      },
    },
  },
}
