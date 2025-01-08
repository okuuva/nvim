return {
  "andrewferrier/wrapping.nvim",
  event = "VeryLazy",
  cmd = {
    "SoftWrapMode",
    "HardWrapMode",
    "ToggleWrapMode",
    "WrappingOpenLog",
  },
  keys = {
    { "[ow", "<cmd>SoftWrapMode<cr>",   desc = "SoftWrapMode" },
    { "]ow", "<cmd>HardWrapMode<cr>",   desc = "HardWrapMode" },
    { "yow", "<cmd>ToggleWrapMode<cr>", desc = "ToggleWrapMode" },
  },
  opts = {
    create_keymaps = false,
    auto_set_mode_filetype_allowlist = {
      "asciidoc",
      -- "gitcommit",  # handled by ftplugin
      "latex",
      "mail",
      "markdown",
      "rst",
      "tex",
      "text",
    },
  }
}
