return {
  "nguyenvukhang/nvim-toggler",
  -- stylua: ignore
  keys = {
    { "gt", function() require("nvim-toggler").toggle() end, desc = "Toggle current word" },
  },
  opts = {
    remove_default_keybinds = true,
  },
}
