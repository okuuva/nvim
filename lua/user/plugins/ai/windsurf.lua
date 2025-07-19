---@type LazyPluginSpec
return {
  "Exafunction/windsurf.nvim",
  cond = require("user.util").ai_helpers_allowed("windsurf.nvim"),
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = {
    "Codeium",
  },
  event = {
    "BufEnter",
  },
  keys = {
    {
      "<C-Space>",
      function()
        require("codeium.virtual_text").cycle_or_complete()
      end,
      mode = { "i" },
      desc = "Request new Windsurf completion",
    },
  },
  opts = {
    enable_chat = true,
    enable_cmp_source = false,
    virtual_text = {
      enabled = true,
      manual = true,
    },
  },
  config = function(_, opts)
    require("codeium").setup(opts)
  end,
}
