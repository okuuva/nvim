-- see https://github.com/gbprod/yanky.nvim#snacks-picker
---@type LazyPluginSpec
return {
  "yanky.nvim",
  -- stylua: ignore
  keys = {
    ---@diagnostic disable-next-line: undefined-field
    { "<leader>sy", function() Snacks.picker.yanky() end, desc = "Yank history" },
  },
  optional = true,
}
