---@type LazyPluginSpec
return {
  "ravitemer/mcphub.nvim",
  version = "v5.*",
  cond = require("user.util").ai_helpers_allowed(),
  keys = {
    { "<leader>am", "<cmd>MCPHub<cr>", desc = "Open MCPHub" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "bundled_build.lua", -- Bundles `mcp-hub` binary along with the neovim plugin
  opts = {
    use_bundled_binary = true,
  },
}
