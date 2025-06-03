---@type LazyPluginSpec
return {
  "ldelossa/gh.nvim",
  dependencies = {
    {
      "ldelossa/litee.nvim",
      config = function()
        require("litee.lib").setup()
      end,
    },
    {
      "topaxi/pipeline.nvim",
      keys = {
        { "<leader>ghp", "<cmd>Pipeline<cr>", desc = "Pipelines" },
      },
      optional = true,
    },
  },
  opts = {},
}
