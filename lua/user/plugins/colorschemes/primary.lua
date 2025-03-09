-- this is meant only to set the priority of the primary colorcheme and to make sure it gets automatically loaded at the
-- right moment
-- the coloscheme plugin configuration should happen in a separate module

local plugin = "material.nvim"
local colorscheme = "material-darker"

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("colorscheme " .. colorscheme)
  end,
})

---@type LazyPluginSpec
return {
  plugin,
  lazy = false,
  priority = 1001,
}
