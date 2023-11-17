return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewLog",
  },
  keys = {
    -- stylua: ignore
    { "<leader>gd", "<cmd>DiffviewFileHistory %<cr>", desc = "Diff" },
    {
      "<leader>gi",
      function()
        vim.cmd(vim.api.nvim_win_get_cursor(0)[1] .. "DiffviewFileHistory<cr>")
      end,
      desc = "Line history",
    },
    { "<leader>gi", "<cmd>'<,'>DiffviewFileHistory<cr>", mode = "v", desc = "Line history" },
  },
  config = true,
}
