local file_types = {
  "gitcommit",
  "jjdescription",
  "markdown",
  "octo",
}

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
    injections = {
      -- identical to the gitcommit injection
      -- except that gitcommit uses (message) instead of (text)
      jjdescription = {
        enabled = true,
        query = [[
            ((text) @injection.content
                (#set! injection.combined)
                (#set! injection.include-children)
                (#set! injection.language "markdown"))
        ]],
      },
    },
  },
}
