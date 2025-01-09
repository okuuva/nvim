return {
  'nguyenvukhang/nvim-toggler',
  keys = {
    { "<leader>i", function() require("nvim-toggler").toggle() end, desc = "Invert current word" },
  },
  opts = {
    remove_default_keybinds = true,
  }
}
