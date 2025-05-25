---@type LazyPluginSpec
return {
  "lewis6991/gitsigns.nvim",
  version = "v1.*",
  event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
  keys = {
    -- regulars
    { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk" },
  },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "󰐊" },
      topdelete = { text = "󰐊" },
      changedelete = { text = "▎" },
    },
    signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      delay = 0,
      ignore_whitespace = true,
    },
  },
}
