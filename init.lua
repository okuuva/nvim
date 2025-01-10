-- set up debugging shortcuts before anything else
-- https://github.com/folke/snacks.nvim/blob/main/docs/debug.md

--Show a notification with a pretty printed dump of the object(s) with lua treesitter highlighting
_G.dd = function(...)
  Snacks.debug.inspect(...)
end

--Show a notification with a pretty backtrace
_G.bt = function()
  Snacks.debug.backtrace()
end

--Override Neovim's vim.print with Snacks.debug.inspect
vim.print = _G.dd

require("user.config")
require("lazy").setup("user.plugins", {
  defaults = {
    lazy = true,
  },
  concurrency = 50,
})
