return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-web-devicons" },
  cmd = { "Oil" },
  event = "VeryLazy",
  keys = {
    { "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
  },
  opts = {
    columns = {
      "permissions",
      "size",
      "mtime",
      "icon",
    },
    view_options = {
      show_hidden = true,
    },
  },
}
