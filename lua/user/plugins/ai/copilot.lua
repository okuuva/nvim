return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  cond = require("user.util").ai_helpers_allowed(),
  opts = {
    panel = {
      -- use codecompanion if available
      enabled = not package.loaded.codecompanion,
    },
    suggestion = {
      -- use supermaven if enabled
      enabled = not package.loaded["supermaven-nvim"],
    },
    server_opts_overrides = {
      settings = {
        telemetry = {
          telemetryLevel = "off",
        },
      },
    },
  },
}
