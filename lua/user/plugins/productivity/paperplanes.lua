---@type LazyPluginSpec
return {
  "rktjmp/paperplanes.nvim",
  keys = {
    { "<leader>PP", "<cmd>PP<cr>", desc = "Send buffer to pastebin" },
    { "<leader>PP", ":PP<cr>", mode = "x", desc = "Send selection to pastebin" },
  },
  cmd = "PP",
  opts = {
    register = "+",
    provider = "dpaste.org",
    provider_options = {},
    notifier = vim.notify,
  },
}
