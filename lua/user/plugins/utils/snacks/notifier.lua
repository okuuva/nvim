---@type LazyPluginSpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>nd", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
  },
  ---@type snacks.Config
  opts = {
    notifier = {
      timeout = 6000,
      top_down = false,
      level = vim.log.levels.INFO,
    },
    styles = {
      notification = {
        wo = {
          wrap = true,
        },
      },
      notification_history = {
        height = 0,
        width = 0,
        wo = {
          wrap = true,
        },
      },
    },
  },
}
