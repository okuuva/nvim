---@type LazyPluginSpec
return {
  "Juksuu/worktrees.nvim",
  dependencies = {
    "plenary.nvim",
  },
  cmd = {
    "GitWorktreeCreate",
    "GitWorktreeCreateExisting",
    "GitWorktreeSwitch",
  },
  -- stylua: ignore
  keys = {
    { "<leader>gW", function() require("worktrees").new_worktree() end, desc = "Create Worktree" },
  },
  opts = {},
}
