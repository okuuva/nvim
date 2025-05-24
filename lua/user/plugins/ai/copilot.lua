return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  cond = require("user.util").ai_helpers_allowed(),
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = false,
    },
  },
}
