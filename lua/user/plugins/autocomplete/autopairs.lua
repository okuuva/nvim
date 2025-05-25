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
  config = function(_, plugin_opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(plugin_opts)

    -- custom rules
    -- see https://github.com/windwp/nvim-autopairs/wiki/Custom-rules
    local ts_conds = require("nvim-autopairs.ts-conds")
    local conds = require("nvim-autopairs.conds")
    local utils = require("nvim-autopairs.utils")
    local Rule = require("nvim-autopairs.rule")

    -- When typing space equals for assignment in Nix, add the final semicolon to the line
    -- Note that when the cursor is at the end of a comment line,
    -- treesitter thinks we are in attrset_expression
    -- because the cursor is "after" the comment, even though it is on the same line.
    local is_not_ts_node_comment_one_back = function()
      return function(info)
        local p = vim.api.nvim_win_get_cursor(0)
        -- Subtract one to account for 1-based row indexing in nvim_win_get_cursor
        -- Also subtract one from the position of the column to see if we are at the end of a comment.
        local pos_adjusted = { p[1] - 1, p[2] - 1 }

        vim.treesitter.get_parser():parse()
        local target = vim.treesitter.get_node({ pos = pos_adjusted, ignore_injections = false })
        if target ~= nil and utils.is_in_table({ "comment" }, target:type()) then
          return false
        end

        local rest_of_line = info.line:sub(info.col)
        return rest_of_line:match("^%s*$") ~= nil
      end
    end

    npairs.add_rules({
      -- add trailing comma to "'} inside lua tables
      Rule("{", "},", "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),
      Rule("'", "',", "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),
      Rule('"', '",', "lua"):with_pair(ts_conds.is_ts_node({ "table_constructor" })),

      Rule("= ", ";", "nix"):with_pair(is_not_ts_node_comment_one_back()):set_end_pair_length(1),

      -- auto-pair <> for generics but not as greater-than/less-than operators
      npairs.add_rule(Rule("<", ">", {
        -- if you use nvim-ts-autotag, you may want to exclude these filetypes from this rule
        -- so that it doesn't conflict with nvim-ts-autotag
        "-html",
        "-javascriptreact",
        "-typescriptreact",
      }):with_pair(
        -- regex will make it so that it will auto-pair on
        -- `a<` but not `a <`
        -- The `:?:?` part makes it also
        -- work on Rust generics like `some_func::<T>()`
        conds.before_regex("%a+:?:?$", 3)
      ):with_move(function(opts)
        return opts.char == ">"
      end)),
    })
  end,
}
