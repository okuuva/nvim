local api = vim.api

-- windows to close with "q"
local file_type_group = api.nvim_create_augroup("_file_type", {})

api.nvim_create_autocmd("FileType", {
  group = file_type_group,
  pattern = { "help", "startuptime", "qf", "lspinfo" },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})

api.nvim_create_autocmd("FileType", {
  group = file_type_group,
  pattern = "man",
  command = [[nnoremap <buffer><silent> q :bdelete<CR>]],
})

local persisted_hooks = api.nvim_create_augroup("PersistedHooks", {})

api.nvim_create_autocmd("User", {
  group = persisted_hooks,
  pattern = { "PersistedLoadPost", "PersistedTelescopeLoadPost" },
  callback = function(session)
    local message = "Autoloaded session"
    if session.data["name"] ~= nil then
      message = "Loaded session " .. session.data.name
    end

    vim.defer_fn(function()
      vim.notify(message, vim.log.levels.INFO, { title = "Session manager" })
    end, 0)
  end,
})
