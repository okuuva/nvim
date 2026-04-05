---@type LazyPluginSpec
return {
  "lewis6991/gitsigns.nvim",
  version = "v2.*",
  event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
  keys = {
    { "<leader>gd", function() require("gitsigns").diffthis() end, desc = "Vimdiff" },
    { "<leader>gq", function() require("gitsigns").setqflist("all") end, desc = "Show hunks in quickfix" },
    { "<leader>gtb", function() require("gitsigns").blame() end, desc = "Blame panel" },
  },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "󰐊" },
      topdelete = { text = "󰐊" },
      changedelete = { text = "▎" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "󰐊" },
      topdelete = { text = "󰐊" },
      changedelete = { text = "▎" },
      untracked = { text = "┆" },
    },
    signs_staged_enable = true, -- also affects numhl
    signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      delay = 0,
      ignore_whitespace = true,
    },
  },
}
