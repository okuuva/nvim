-- see https://github.com/Juksuu/worktrees.nvim#snacksnvim
---@type LazyPluginSpec
return {
  "worktrees.nvim",
  -- stylua: ignore
  keys = {
    ---@diagnostic disable-next-line: undefined-field
    { "<leader>gw", function() Snacks.picker.worktrees() end, desc = "List Worktrees" },
    ---@diagnostic disable-next-line: undefined-field
    { "<leader>gW", function() Snacks.picker.worktrees_new() end, desc = "New Worktree" },
  },
  optional = true,
}
