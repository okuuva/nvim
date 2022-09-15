local status_ok, autosave = pcall(require, "autosave")
if not status_ok then
  return
end

local execution_message = function() -- message to print on save
  return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
end

local excluded_filetypes = {}
local excluded_filenames = {
  "plugins.lua",
  "autosave.lua",
}

local save_condition = function(buf)
  local fn = vim.fn
  local utils = require("auto-save.utils.data")

  if
    fn.getbufvar(buf, "&modifiable") == 1
    and utils.not_in(fn.getbufvar(buf, "&filetype"), excluded_filetypes)
    and utils.not_in(fn.expand("%:t"), excluded_filenames)
  then
    return true -- met condition(s), can save
  end
  return false -- can't save
end

autosave.setup({
  enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
  execution_message = {
    message = execution_message,
    dim = 0.18, -- dim the color of `message`
    cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
  },
  trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
  -- function that determines whether to save the current buffer or not
  -- return true: if buffer is ok to be saved
  -- return false: if it's not ok to be saved
  condition = save_condition,
  write_all_buffers = false, -- write all buffers when the current one meets `condition`
  debounce_delay = 135, -- saves the file at most every `debounce_delay` milliseconds
  callbacks = { -- functions to be executed at different intervals
    enabling = nil, -- ran when enabling auto-save
    disabling = nil, -- ran when disabling auto-save
    before_asserting_save = nil, -- ran before checking `condition`
    before_saving = nil, -- ran before doing the actual save
    after_saving = nil, -- ran after doing the actual save
  },
})
