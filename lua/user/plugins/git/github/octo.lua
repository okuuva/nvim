---@type LazyPluginSpec
return {
  "pwntester/octo.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "topaxi/pipeline.nvim",
      keys = {
        { "<leader>ghp", "<cmd>Pipeline<cr>", desc = "Pipelines" },
      },
      optional = true,
    },
  },
  cmd = {
    "Octo",
  },
  keys = {
    { "<leader>ghi", "<cmd>Octo issues<cr>", desc = "Issues" },
  },
  opts = {
    enable_builtin = true, -- shows a list of builtin actions when no action is provided
    default_merge_method = "rebase", -- default merge method which should be used for both `Octo pr merge` and merging from picker, could be `commit`, `rebase` or `squash`
    default_delete_branch = true, -- whether to delete branch when merging pull request with either `Octo pr merge` or from picker (can be overridden with `delete`/`nodelete` argument to `Octo pr merge`)
    picker = "snacks", -- or "fzf-lua" or "telescope"
  },
}
