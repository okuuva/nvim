local file_types = { "markdown", "Avante", "gitcommit", "codecompanion" }

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter",
    "mini.icons",
    "nvim-web-devicons",
  },
  ft = file_types,
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = file_types,
    win_options = {
      concealcursor = { rendered = "nc" }, -- _really_ disable anti-conceal on the cursor line
    },
  },
}
