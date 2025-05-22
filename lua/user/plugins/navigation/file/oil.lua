---@type oil.OpenOpts
local default_opts = {
  preview = {
    split = "belowright",
  },
}

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
      -- htns jkl;
      -- disable keymaps that conflict with harpoon by setting them to false
      ["<C-h>"] = false,
      ["<C-t>"] = false,
      ["<C-s>"] = false,
      ["<C-l>"] = false,
      ["<C-c>"] = false, -- esc, q, and <leader>c are enough already
      ["<Esc>"] = { "actions.close", mode = "n" },
      ["q"] = { "actions.close", mode = "n" },
    },
  },
}
