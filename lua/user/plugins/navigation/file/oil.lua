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
      ["<C-c>"] = false, -- <leader>c closes buffer, no need for a plugin specific mapping
    },
  },
}
