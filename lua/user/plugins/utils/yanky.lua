--- Sync tmux's paste buffer with the terminal's clipboard.
--- This is needed because tmux intercepts OSC52 clipboard queries and
--- responds with its own internal buffer instead of forwarding to the terminal.
local function sync_tmux_clipboard()
  local in_tmux = vim.env.TMUX ~= nil
  if in_tmux then
    vim.fn.system({ "tmux", "refresh-client", "-l" })
    -- Small delay to allow tmux to receive the clipboard response
    vim.uv.sleep(10)
  end
end

-- Clipboard configuration:
-- Use OSC52 for clipboard sync everywhere (works through tmux/SSH).
-- When running inside tmux, we need to call `tmux refresh-client -l`
-- before reading to sync tmux's buffer with the terminal's clipboard
-- (otherwise tmux returns stale data from its internal paste buffer).
local function get_osc52_clipboard()
  local osc52 = require("vim.ui.clipboard.osc52")

  return {
    name = "OSC 52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = function()
        sync_tmux_clipboard()
        return osc52.paste("+")()
      end,
      ["*"] = function()
        sync_tmux_clipboard()
        return osc52.paste("*")()
      end,
    },
  }
end

vim.g.clipboard = get_osc52_clipboard()

return {
  "gbprod/yanky.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  keys = {
    { "y", "<Plug>(YankyYank)", desc = "Yank text", mode = { "n", "x" } },
    { "p", "<Plug>(YankyPutAfter)", desc = "Put after cursor", mode = { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", desc = "Put before cursor", mode = { "n", "x" } },
    { "gp", "<Plug>(YankyGPutAfter)", desc = "Put after selection", mode = { "n", "x" } },
    { "gP", "<Plug>(YankyGPutBefore)", desc = "Put before selection", mode = { "n", "x" } },
    { "]P", "<Plug>(YankyPutIndentAfter)", desc = "Put indented after cursor", mode = { "n", "x" } },
    { "[P", "<Plug>(YankyPutIndentBefore)", desc = "Put indented before cursor", mode = { "n", "x" } },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
    { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
    { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
  },
  opts = {
    ring = {
      history_length = 100,
      storage = "sqlite",
      sync_with_numbered_registers = true,
      cancel_event = "update",
    },
    picker = {
      select = {
        action = nil, -- nil to use default put action
      },
    },
    system_clipboard = {
      sync_with_ring = true,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 500,
    },
    preserve_cursor_position = {
      enabled = true,
    },
  },
}
