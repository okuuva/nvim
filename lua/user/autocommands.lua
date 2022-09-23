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
