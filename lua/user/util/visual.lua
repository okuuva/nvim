local M = {}

---@class SelectionPos
---@field row number 1-based
---@field col number 1-based

---@class Selection
---@field mode "v" | "V" | "\22" | ""
---@field start SelectionPos
---@field end_ SelectionPos
---@field text string

---@param sel Selection
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

---@param sel Selection
local function reset_cursor(sel)
  vim.api.nvim_win_set_cursor(0, { sel.start.row, sel.start.col - 1 })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

---@return Selection
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

---@return Selection
function M.get_current_word()
  -- Temporarily add '=' to iskeyword to capture base64 padding
  local original_iskeyword = vim.bo.iskeyword
  vim.bo.iskeyword = vim.bo.iskeyword .. ",="

  local word = vim.fn.expand("<cword>")
  local pos = vim.fn.searchpos("\\<" .. vim.fn.escape(word, "\\"), "bcnW")

  -- Restore original iskeyword
  vim.bo.iskeyword = original_iskeyword

  return {
    mode = "",
    start = { row = pos[1], col = pos[2] },
    end_ = { row = pos[1], col = pos[2] + #word - 1 },
    text = word,
  }
end

---@return Selection
function M.get_word_or_selection()
  local mode = vim.api.nvim_get_mode().mode
  if mode == "v" or mode == "V" or mode == "\22" then
    return M.get_visual_selection()
  end
  return M.get_current_word()
end

--- Modify visual selection or current word with a function
--- @param modifier fun(text:string):string function to modify the selection
function M.modify(modifier)
  local sel = M.get_word_or_selection()
  local modified = modifier(sel.text)
  if modified ~= "" then
    replace_selection(sel, modified)
  end
  if sel.mode ~= "" then
    reset_cursor(sel)
  end
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

--- Base64 encode selection
function M.base64_encode()
  M.modify(base64_encode)
end

--- Base64 decode selection
function M.base64_decode()
  M.modify(base64_decode)
end

--- Base64 decode or encode selection
function M.base64_toggle()
  M.modify(function(text)
    local decoded = base64_decode(text)
    return decoded ~= "" and decoded or base64_encode(text)
  end)
end

local function relpath()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
end

local function notify_copied(result)
  vim.fn.setreg("+", result)
  Snacks.notify(result, { title = "Copied path" })
end

--- Copy file path to clipboard
function M.copy_path()
  notify_copied(relpath())
end

--- Copy file path with line and column to clipboard
--- In visual mode, copies the position range
---@return string
local function path_location()
  local path = relpath()

  local visual_mode = vim.api.nvim_get_mode().mode:match("[vV\22]")
  if not visual_mode then
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    col = col + 1 -- make it inclusive
    return path .. ":" .. line .. ":" .. col
  end

  local from_line = vim.fn.line("v")
  local from_col = vim.fn.col("v")
  local to_line = vim.fn.line(".")
  local to_col = vim.fn.col(".")

  local on_same_line = from_line == to_line
  local line_is_reversed = from_line > to_line
  local col_is_reversed = on_same_line and from_col > to_col
  local selection_is_reversed = line_is_reversed or col_is_reversed

  if selection_is_reversed then
    from_line, to_line = to_line, from_line
    from_col, to_col = to_col, from_col
  end

  path = path .. ":" .. from_line .. ":" .. from_col

  local on_same_col = from_col == to_col
  local is_range = not (on_same_line and on_same_col)
  if is_range then
    path = path .. "-" .. to_line .. ":" .. to_col
  end

  return path
end

--- Copy file path:line to clipboard
function M.copy_path_line()
  notify_copied(path_location():gsub(":%d+%-", "-"):gsub(":%d+$", ""))
end

--- Copy file path:line:col to clipboard
function M.copy_path_location()
  notify_copied(path_location())
end

return M
