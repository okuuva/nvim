return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
  keys = {
    -- regulars
    { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk" },
    { "<leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Reset Buffer" },
    { "<leader>ga", function() require("gitsigns").stage_hunk() end, desc = "Add Hunk to Stage" },
    { "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo Last Stage Hunk" },
    -- toggles
    { "<leader>gtb", function() require("gitsigns").toggle_current_line_blame() end, desc = "Current line blame" },
    { "<leader>gtd", function() require("gitsigns").toggle_deleted() end, desc = "Deleted lines" },
    { "<leader>gtw", function() require("gitsigns").toggle_word_diff() end, desc = "Word diff" },
    { "<leader>gtl", function() require("gitsigns").toggle_linehl() end, desc = "Line highlight" },
    { "<leader>gtn", function() require("gitsigns").toggle_numhl() end, desc = "Number highlight" },
    -- { "<leader>gts", function() require("gitsigns").toggle_signs() end, desc = "Sign column" },
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
    show_deleted = false,
  },
}
