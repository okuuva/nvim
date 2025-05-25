---@type LazyPluginSpec
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
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    -- add trailing comma to nested tables
    local ts_conds = require("nvim-autopairs.ts-conds")
    local Rule = require("nvim-autopairs.rule")
    npairs.add_rules({
      Rule("{", "},", "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),
      Rule("'", "',", "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),
      Rule('"', '",', "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),
    })
  end,
}
