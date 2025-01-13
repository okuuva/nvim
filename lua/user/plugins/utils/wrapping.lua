return {
  "andrewferrier/wrapping.nvim",
  event = "VeryLazy",
  cmd = {
    "SoftWrapMode",
    "HardWrapMode",
    "ToggleWrapMode",
    "WrappingOpenLog",
  },
  -- stylua: ignore
  keys = {
    { "[ow", "<cmd>SoftWrapMode<cr>",   desc = "SoftWrapMode" },
    { "]ow", "<cmd>HardWrapMode<cr>",   desc = "HardWrapMode" },
    { "yow", "<cmd>ToggleWrapMode<cr>", desc = "ToggleWrapMode" },
  },
  opts = {
    create_keymaps = false,
    softener = {
      snacks_notif_history = true,
    },
    auto_set_mode_filetype_allowlist = {
      "asciidoc",
      -- "gitcommit",  # handled by ftplugin
      "latex",
      "mail",
      "markdown",
      "rst",
      "snacks_notif_history",
      "tex",
      "text",
    },
  },
}
