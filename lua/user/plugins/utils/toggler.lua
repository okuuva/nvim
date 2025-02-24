return {
  "nguyenvukhang/nvim-toggler",
  -- stylua: ignore
  keys = {
    { "<leader>f", function() require("nvim-toggler").toggle() end, desc = "Flip current word" },
  },
  opts = {
    remove_default_keybinds = true,
  },
}
