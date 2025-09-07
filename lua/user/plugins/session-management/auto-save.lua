local excluded_filetypes = {
  "gitcommit", -- commits should definitely be saved explicitly
  "jjdescription", -- commits should definitely be saved explicitly
  "oil", -- auto-saving a buffer that potentially edits filesystem is a very bad idea
}
local excluded_filenames = {
  "auto-save.lua",
}

---@param buf string|integer
---@return boolean
local function save_condition(buf)
  if
    vim.list_contains(excluded_filetypes, vim.fn.getbufvar(buf, "&filetype"))
    or vim.list_contains(excluded_filenames, vim.fn.expand("%:t"))
  then
    return false
  end
  return true
end

local immediate_triggers = { "BufLeave", "FocusLost" } -- vim events that trigger auto-save. See :h events
local deferred_triggers = { "InsertLeave", "TextChanged" }

return {
  "okuuva/auto-save.nvim",
  version = "^1.0.0",
  event = vim.tbl_deep_extend("force", immediate_triggers, deferred_triggers),
  opts = {
    enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
    trigger_events = { -- See :h events
      immediate_save = immediate_triggers, -- vim events that trigger an immediate save
      defer_save = deferred_triggers, -- vim events that trigger a deferred save (saves after `debounce_delay`)
      cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
    },
    -- function that determines whether to save the current buffer or not
    -- return true: if buffer is ok to be saved
    -- return false: if it's not ok to be saved
    condition = save_condition,
    write_all_buffers = false, -- write all buffers when the current one meets `condition`
    noautocmd = true, -- do not execute autocmds when saving
    debounce_delay = 1000, -- saves the file at most every `debounce_delay` milliseconds
    callbacks = { -- functions to be executed at different intervals
      before_saving = nil, -- ran before doing the actual save
    },
  },
}
