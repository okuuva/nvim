local M = {}

local LAST_HELP = vim.fn.stdpath("data") .. "/last_help"

--- Save the current help file path and cursor position.
---@param buf number
function M.save_last(buf)
  local path = vim.api.nvim_buf_get_name(buf)
  if path == "" then
    return
  end
  local line = 1
  local win = vim.fn.bufwinid(buf)
  if win ~= -1 then
    line = vim.api.nvim_win_get_cursor(win)[1]
  end
  vim.fn.writefile({ "+" .. line .. " " .. path }, LAST_HELP)
end

--- Toggle the help panel: hide if visible, reopen last help buffer,
--- or fall back to the persisted help file from a previous session.
function M.toggle()
  -- If a help window is visible, save position and hide it
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "help" then
      M.save_last(buf)
      vim.api.nvim_win_hide(win)
      return
    end
  end
  -- If a help buffer is loaded but hidden, show it
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "help" and vim.api.nvim_buf_is_loaded(buf) then
      vim.cmd("help")
      vim.api.nvim_set_current_buf(buf)
      return
    end
  end
  -- Fall back to the persisted help file from a previous session
  if vim.fn.filereadable(LAST_HELP) == 1 then
    local line = vim.fn.readfile(LAST_HELP)[1]
    if line and line ~= "" then
      vim.cmd("split " .. line)
      vim.bo.buftype = "help"
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.cmd("normal! zz")
    end
  end
end

return M
