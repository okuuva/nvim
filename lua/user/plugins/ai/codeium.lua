return {
  "jcdickinson/codeium.nvim",
  enabled = false,
  event = "VeryLazy",
  cmd = "Codeium",
  cond = not vim.g.alpine_linux and AI_Check_disabled_patters(),
  dependencies = { "nvim-cmp" },
  config = true,
}
