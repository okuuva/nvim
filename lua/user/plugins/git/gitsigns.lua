return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
  keys = {
    -- regulars
    { "<leader>gl", function() require("gitsigns").blame_line({ full = true, ignore_whitespace = true }) end, desc = "Blame" },
    { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk" },
    { "<leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Reset Buffer" },
    -- toggles
    { "<leader>gtb", function() require("gitsigns").toggle_current_line_blame() end, desc = "Current line blame" },
    { "<leader>gtd", function() require("gitsigns").toggle_deleted() end, desc = "Deleted lines" },
    { "<leader>gtw", function() require("gitsigns").toggle_word_diff() end, desc = "Word diff" },
    { "<leader>gtl", function() require("gitsigns").toggle_linehl() end, desc = "Line highlight" },
    { "<leader>gtn", function() require("gitsigns").toggle_numhl() end, desc = "Number highlight" },
    { "<leader>gts", function() require("gitsigns").toggle_signs() end, desc = "Sign column" },
  },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "󰐊" },
      topdelete = { text = "󰐊" },
      changedelete = { text = "▎" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 0,
      ignore_whitespace = true,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    show_deleted = false,
    diff_opts = {
      algorithm = "histogram",
    },
    yadm = {
      enable = false,
    },
    on_attach = nil,
  },
}
