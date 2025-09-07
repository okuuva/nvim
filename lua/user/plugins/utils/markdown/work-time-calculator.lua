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
    date_format = "%Y/%m/%Y-%m-%d",
    output_file = vim.fn.expand("time-tracking-%Y-%m.md"),
    workday_length = "06:00",
  },
}
