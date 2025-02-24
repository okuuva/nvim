return {
  "Exafunction/codeium.nvim",
  enabled = false,
  event = "VeryLazy",
  cmd = "Codeium",
  cond = not RUNNING_ON_ALPINE and require("user.util").ai_helpers_allowed(),
  dependencies = {
    "plenary.nvim",
    "nvim-cmp",
  },
  opts = {},
}
