return {
  "ziontee113/color-picker.nvim",
  cmd = { "PickColor", "PickColorInsert" },
  keys = {
    { "<C-c>", "<cmd>PickColor<cr>", desc = "Pick color" },
    { "<C-c>", "<cmd>PickColorInsert<cr>", mode = "i", desc = "Pick color" },
  },
  opts = {
    ["icons"] = { "☐", "" },
  },
}
