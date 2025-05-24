---@type LazyPluginSpec
return {
  "ravitemer/mcphub.nvim",
  version = "v5.*",
  cond = require("user.util").ai_helpers_allowed(),
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
  opts = {},
}
