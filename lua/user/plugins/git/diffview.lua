local function ToggleWrapInAllDiffViews()
  -- Save the current window number
  local current_win = vim.api.nvim_get_current_win()

  -- Iterate over all window IDs
  for _, win in pairs(vim.api.nvim_list_wins()) do
    -- Set the window as the current window
    vim.api.nvim_set_current_win(win)
    -- Check if the window is in diff mode
    if vim.wo.diff then
      -- Toggle the 'wrap' option
      vim.wo.wrap = not vim.wo.wrap
    end
  end

  -- Restore the focus to the original window
  vim.api.nvim_set_current_win(current_win)
end

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
  init = function()
    -- set fillchar to "╱"
    vim.opt.fillchars:append({ diff = "╱" })
  end,
  opts = function()
    local actions = require("diffview.actions")
    local common_keymaps = {
      { "n", "<leader>t", ToggleWrapInAllDiffViews, { desc = "Toggle word wrap" } },
      { "n", "<leader>C", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
      { "n", "<leader>e", actions.toggle_files, { desc = "Toggle the file panel" } },
      { "n", "<leader>b", false }, -- disable default toggle files
    }
    return {
      enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
      keymaps = {
        view = common_keymaps,
        file_panel = common_keymaps,
        file_history_panel = common_keymaps,
      },
    }
  end,
}
