---@type LazyPluginSpec
return {
  "okuuva/work-time-calculator.nvim",
  branch = "dev",
  -- dir = "~/gits/neovim/work-time-calculator.nvim.git/dev",
  dependencies = {
    "obsidian.nvim",
    "markdown-table-mode.nvim",
  },
  -- stylua: ignore
  keys = {
    { "<leader>oh", function() require("work-time-calculator").calculate_time() end, desc = "Generate hours table"},
  },
  opts = {
    daily_notes_dir = vim.fn.expand("~/Notes/notes/dailies"),
    output_file = vim.fn.expand("~/Notes/notes/1740225022-hours.md"),
    workday_length = "06:00",
  },
}
