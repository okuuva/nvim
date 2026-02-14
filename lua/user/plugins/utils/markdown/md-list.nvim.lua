---@type LazyPluginSpec
return {
  "oliver-hughes/md-list.nvim",
  ft = require("user.util").markdown_filetypes,
  ---@module "mdlist"
  opts = {
    colon_list_marker = "-",
    filetypes = require("user.util").markdown_filetypes,
  },
}
