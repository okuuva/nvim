local treesitter_installed, _ = pcall(require, "nvim-treesitter")
if not treesitter_installed then
  return
end

require("user.treesitter.configs")
require("user.treesitter.comment")
require("user.treesitter.autopairs")
require("user.treesitter.twilight")
require("user.treesitter.context")
