---@type LazyPluginSpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
  },
  ---@type snacks.Config
  opts = {
    picker = {
      sources = {
        highlights = {
          confirm = "hl_group_put",
          actions = {
            hl_group_put = function(picker)
              local items = picker:selected({ fallback = true })
              picker:close()
              local lines = {}
              for _, item in ipairs(items) do
                lines[#lines + 1] = item.hl_group
              end
              vim.api.nvim_put(lines, "", true, true)
            end,
          },
        },
      },
    },
  },
  optional = true,
}
