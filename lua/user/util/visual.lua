local M = {}

---@class VisualSelectionLocation
---@field row number 1-based
---@field col number 1-based

---@class VisualSelection
---@field mode "v" | "V" | "\22"
---@field start VisualSelectionLocation
---@field end_ VisualSelectionLocation
---@field text string

---@param sel VisualSelection
---@param replacement string
local function replace_selection(sel, replacement)
  vim.api.nvim_buf_set_text(
    0,
    sel.start.row - 1,
    sel.start.col - 1,
    sel.end_.row - 1,
    sel.end_.col,
    vim.split(replacement, "\n")
  )
end

---@param sel VisualSelection
local function reset_cursor(sel)
  vim.api.nvim_win_set_cursor(0, { sel.start.row, sel.start.col - 1 })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

---@return VisualSelection
function M.get_visual_selection()
  -- Force visual mode info and visual marks `<` and `>` to refresh
  -- ESC then gv preserves current visual region and ensures marks and mode are updated
  vim.cmd("noautocmd normal! gv")

  local start = vim.fn.getpos("'<")
  local end_ = vim.fn.getpos("'>")
  local mode = vim.fn.visualmode()

  local lines = vim.fn.getregion(start, end_, { type = mode })

  -- end_.col is v:maxcol in linewise mode and might be off by one in charwise and blockwise modes,
  -- set it to the real value instead
  local end_col = math.min(end_[3], vim.fn.col({ end_[2], "$" }) - 1)

  return {
    mode = mode,
    start = { row = start[2], col = start[3] },
    end_ = { row = end_[2], col = end_col },
    text = table.concat(lines, "\n"),
  }
end

--- Modify visual selection with a function
--- @param modifier fun(text:string):string function to modify the selection
function M.modify(modifier)
  local sel = M.get_visual_selection()
  local modified = modifier(sel.text)
  if modified ~= "" then
    replace_selection(sel, modified)
  end
  reset_cursor(sel)
end

local function is_ascii(s)
  for i = 1, #s do
    local b = s:byte(i)
    if not (b == 9 or b == 10 or (b >= 32 and b <= 126)) then
      return false
    end
  end
  return true
end

---@param text string
---@return string
local function base64_encode(text)
  local ok, result = pcall(vim.base64.encode, text)
  if ok and is_ascii(result:sub(1, 3)) then
    return result:gsub("\n$", "")
  end
  return ""
end

---@param text string
---@return string
local function base64_decode(text)
  local ok, result = pcall(vim.base64.decode, text)
  if ok and is_ascii(result:sub(1, 3)) then
    return result:gsub("\n$", "")
  end
  return ""
end

--- Base64 encode visual selection
function M.base64_encode()
  M.modify(base64_encode)
end

--- Base64 decode visual selection
function M.base64_decode()
  M.modify(base64_decode)
end

--- Base64 decode or encode visual selection
function M.base64_toggle()
  M.modify(function(text)
    local decoded = base64_decode(text)
    return decoded ~= "" and decoded or base64_encode(text)
  end)
end

return M
