return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
  keys = {
    -- regulars
    { "<leader>gL", function() require("gitsigns").blame_line({ full = true, ignore_whitespace = true }) end, desc = "Blame" },
    { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk" },
    { "<leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Reset Buffer" },
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
    -- FIXME: signcolumn can't be turned off without statuscol panicing
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    -- TODO: check how internal and indent_heuristic works
    diff_opts = {
      algorithm = "histogram",
      internal = false,
      indent_heuristic = false,
    },
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      delay = 0,
      ignore_whitespace = true,
    },
    show_deleted = false,
  },
}
