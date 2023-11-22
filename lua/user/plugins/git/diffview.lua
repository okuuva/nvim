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
