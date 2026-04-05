---@type oil.OpenOpts
local default_opts = {
  preview = {
    split = "belowright",
  },
}

---@type LazyPluginSpec
return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-web-devicons" },
  cmd = { "Oil" },
  event = "VeryLazy",
  keys = {
    {
      "-",
      function()
        require("oil").open_float(nil, default_opts)
      end,
      { desc = "Open parent directory" },
    },
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
    keymaps = {
      ["<Esc>"] = { "actions.close", mode = "n" },
      ["q"] = { "actions.close", mode = "n" },
      ["<PageUp>"] = "actions.preview_scroll_up",
      ["<PageDown>"] = "actions.preview_scroll_down",
    },
    preview_win = {
      preview_method = "scratch",
    },
  },
}
