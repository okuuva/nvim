return {
  'nguyenvukhang/nvim-toggler',
  keys = {
    { "<leader>t", function() require("nvim-toggler").toggle() end, desc = "Toggle current word" },
  },
  opts = {
    remove_default_keybinds = true,
  }
}
