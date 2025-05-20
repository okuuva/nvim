-- see https://github.com/L3MON4D3/LuaSnip/issues/656
-- https://github.com/L3MON4D3/LuaSnip/issues/747#issuecomment-1406946217
-- https://github.com/L3MON4D3/LuaSnip/issues/656#issuecomment-1500869758
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(event)
    if event.data ~= "luasnip" then
      return
    end
    local ls = require("luasnip")
    vim.api.nvim_create_autocmd("ModeChanged", {
      group = vim.api.nvim_create_augroup("UnlinkLuaSnipSnippetOnModeChange", {
        clear = true,
      }),
      pattern = { "s:n", "i:*" },
      desc = "Forget the current snippet when leaving the insert mode",
      callback = function(ev)
        if not ls.session or not ls.session.current_nodes[ev.buf] or ls.session.jump_active then
          return
        end

        local current_node = ls.session.current_nodes[ev.buf]
        local current_start, current_end = current_node:get_buf_position()
        current_start[1] = current_start[1] + 1 -- (1, 0) indexed
        current_end[1] = current_end[1] + 1 -- (1, 0) indexed
        local cursor = vim.api.nvim_win_get_cursor(0)

        if
          cursor[1] < current_start[1]
          or cursor[1] > current_end[1]
          or cursor[2] < current_start[2]
          or cursor[2] > current_end[2]
        then
          ls.unlink_current()
        end
      end,
    })
    return true -- disable autocommand after luasnip is loaded
  end,
})

---@type LazyPluginSpec
return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*",
  -- install jsregexp (optional!).
  -- build = "make install_jsregexp"
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
  config = function(_, opts)
    require("luasnip").setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = vim.fn.stdpath("config") .. "/snippets",
    })
  end,
}
