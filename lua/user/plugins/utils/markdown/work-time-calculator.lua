---@type LazyPluginSpec
return {
  "okuuva/work-time-calculator.nvim",
  dir = "~/gits/neovim/work-time-calculator.nvim.git/dev",
  dependencies = {
    "obsidian.nvim",
    {
      "Ask-786/time-calculator.nvim",
      dir = "~/gits/neovim/time-calculator.nvim.git/.bare/dev",
      opts = {
        keymap = nil, -- do not set any keymap
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>oh", desc = "Hours management"},
    { "<leader>ohg", function() require("work-time-calculator").calculate_time() end, desc = "Generate hours table"},
    { "<leader>ohc", function() require("time-calculator").calculate_time() end, desc = "Calculate time in this note"},
  },
  opts = {},
}
