require("messages").setup({
  command_name = "Messages",
  -- should prepare a new buffer and return the winid
  -- by default opens a floating window
  -- provide a different callback to change this behaviour
  -- @param opts: the return value from float_opts
  prepare_buffer = function(opts)
    local buf = vim.api.nvim_create_buf(false, true)
    return vim.api.nvim_open_win(buf, true, opts)
  end,
  -- should return options passed to prepare_buffer
  -- @param lines: a list of the lines of text
  buffer_opts = function()
    local gheight = vim.api.nvim_list_uis()[1].height
    local gwidth = vim.api.nvim_list_uis()[1].width
    return {
      relative = "editor",
      width = gwidth,
      height = gheight,
      anchor = "SW",
      row = gheight - 1,
      col = 0,
      style = "minimal",
      border = "none",
      zindex = 1,
    }
  end,
  -- what to do after opening the float
  post_open_float = function(winnr) end,
})

-- global function for easier usage
Msg = function(...)
  require('messages.api').capture_thing(...)
end
