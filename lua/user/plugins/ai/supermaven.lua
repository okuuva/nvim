---@type LazyPluginSpec
return {
  "supermaven-inc/supermaven-nvim",
  cond = require("user.util").ai_helpers_allowed(),
  dependencies = {
    "lspkind.nvim",
  },
  opts = {
    disable_inline_completion = true,
    disable_keymaps = true,
  },
}
