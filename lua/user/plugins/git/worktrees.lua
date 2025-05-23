---@type LazyPluginSpec
return {
  "Juksuu/worktrees.nvim",
  dir = "~/gits/neovim/worktrees.nvim.git/snacks-new-worktree-picker/",
  dependencies = {
    "plenary.nvim",
  },
  cmd = {
    "GitWorktreeCreate",
    "GitWorktreeCreateExisting",
    "GitWorktreeSwitch",
  },
  opts = {},
}
