return {
  "jcdickinson/codeium.nvim",
  enabled = false,
  event = "VeryLazy",
  cmd = "Codeium",
  cond = not vim.g.alpine_linux and require("user.util").ai_helpers_allowed(),
  dependencies = { "nvim-cmp" },
  config = true,
}
