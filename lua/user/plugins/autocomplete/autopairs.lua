return {
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  event = "InsertEnter",
  opts = {
    check_ts = true, -- use treesitter
    ts_config = {
      lua = { "string" }, -- it will not add a pair on that treesitter node
      javascript = { "template_string" },
      java = false, -- don't check treesitter on java
    },
  },
}
