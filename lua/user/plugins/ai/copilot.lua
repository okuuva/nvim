return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  cond = require("user.util").ai_helpers_allowed("zbirenbaum/copilot.lua"),
  opts = {
    panel = {
      -- use codecompanion if available
      enabled = not package.loaded.codecompanion,
    },
    suggestion = {
      enabled = false,
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
