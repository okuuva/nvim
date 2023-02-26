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

    -- open nvim-tree as unfocused
    local nvim_tree_available, nvim_tree = pcall(require, "nvim-tree.api")
    if nvim_tree_available then
      nvim_tree.tree.toggle({ focus = false })
    end
    local tint_available, tint = pcall(require, "tint")
    if tint_available then
      tint.refresh()
      tint.disable()
      tint.enable()
    end
    vim.defer_fn(function()
      vim.notify(message, vim.log.levels.INFO, { title = "Session manager" })
    end, 0)
  end,
})

api.nvim_create_autocmd({ "User" }, {
  pattern = "PersistedSavePre",
  group = persisted_hooks,
  callback = function()
    pcall(vim.cmd, "NvimTreeClose")
  end,
})
