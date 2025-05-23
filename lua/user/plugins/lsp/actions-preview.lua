return {
  "aznhe21/actions-preview.nvim",
  keys = {
    -- stylua: ignore
    { "gra", function () require("actions-preview").code_actions() end, mode = {"n", "x" }, desc = "Code Action" },
  },
  opts = {},
}
