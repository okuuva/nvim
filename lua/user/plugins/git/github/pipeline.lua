---@type LazyPluginSpec
return {
  "topaxi/pipeline.nvim",
  keys = {
    { "<leader>ghp", "<cmd>Pipeline<cr>", desc = "Pipelines" },
    { "<leader>glp", "<cmd>Pipeline<cr>", desc = "Pipelines" },
  },
  ---@type pipeline.Config
  opts = {},
}
