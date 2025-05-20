-- see https://github.com/Juksuu/worktrees.nvim#snacksnvim
---@type LazyPluginSpec
return {
  "worktrees.nvim",
  keys = {
    { "<leader>gw" }, -- ensure the plugin gets loaded as well
  },
  specs = {
    "snacks.nvim",
    -- stylua: ignore
    keys = {
      ---@diagnostic disable-next-line: undefined-field
      { "<leader>gw", function() Snacks.picker.worktrees() end, desc = "List Worktrees" },
    },
  },
  optional = true,
}
