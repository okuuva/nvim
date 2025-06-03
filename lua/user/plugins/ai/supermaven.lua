---@type LazyPluginSpec
return {
  "supermaven-inc/supermaven-nvim",
  cond = require("user.util").ai_helpers_allowed("supermaven-nvim"),
  dependencies = {
    "lspkind.nvim",
  },
  opts = {
    disable_inline_completion = true,
    disable_keymaps = true,
  },
}
