---@type LazyPluginSpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>.",  function() Snacks.scratch({ft = "lua"}) end, desc = "Toggle Scratch Buffer" },
    { "<leader>SS", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer for current filetype" },
    { "<leader>sB", function() Snacks.scratch.select() end, desc = "Scratch Buffers" },
  },
  ---@type snacks.Config
  opts = {
    scratch = { enabled = true },
  },
}
