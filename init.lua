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

-- This is a dirty hack but it works when using page so...
-- https://github.com/olimorris/persisted.nvim/pull/76#issuecomment-2294914746
-- https://github.com/I60R/page/issues/39#issuecomment-1447660752
_G.USING_PAGE = vim.tbl_contains(vim.v.argv, "--listen")

local function check_alpine()
  local os = vim.uv.os_uname().version
  if os:find("Alpine") or os:find("alpine") then
    return true
  end
  return false
end

_G.RUNNING_ON_ALPINE = check_alpine()

require("user.config")
require("lazy").setup("user.plugins", {
  defaults = {
    lazy = true,
  },
  concurrency = 50,
})
