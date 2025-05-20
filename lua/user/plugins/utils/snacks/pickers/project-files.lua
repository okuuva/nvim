---@type LazyPluginSpec
return {
  "snacks.nvim",
  keys = {
    {
      "<leader><space>",
      function()
        Snacks.picker.files({
          dirs = { Snacks.git.get_root() or vim.fn.getcwd() },
          follow = true,
          hidden = true,
          title = "Project Files",
        })
      end,
      desc = "Find Project Files",
    },
  },
  ---@type snacks.Config
  opts = {},
  optional = true,
}
