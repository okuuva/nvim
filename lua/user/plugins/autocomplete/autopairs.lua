return {
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  event = "InsertEnter",
  dependencies = {
    "nvim-cmp",
  },
  opts = {
    check_ts = true, -- use treesitter
    ts_config = {
      lua = { "string" }, -- it will not add a pair on that treesitter node
      javascript = { "template_string" },
      java = false, -- don't check treesitter on java
    },
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
