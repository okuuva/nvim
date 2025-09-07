---@type LazyPluginSpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>.",  function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
    { "<leader>sB", function() Snacks.scratch.select() end, desc = "Scratch Buffers" },
  },
  ---@type snacks.Config
  opts = {
    scratch = { enabled = true },
  },
}
