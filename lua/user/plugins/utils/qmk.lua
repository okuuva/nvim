---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "codethread/qmk.nvim",
      event = "BufEnter *keymap.c",
      opts = {
        -- these values are mandatory for the initial setup even if they're never used because the get overridden by
        -- inline JSON
        name = "placeholder",
        layout = { "x" },
      },
    },
  },
}
