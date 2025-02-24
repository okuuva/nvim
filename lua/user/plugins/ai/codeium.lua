return {
  "jcdickinson/codeium.nvim",
  enabled = false,
  event = "VeryLazy",
  cmd = "Codeium",
  dependencies = { "nvim-cmp" },
  config = true,
  cond = not RUNNING_ON_ALPINE and require("user.util").ai_helpers_allowed(),
}
