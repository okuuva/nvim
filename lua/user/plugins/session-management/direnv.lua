return {
  "direnv/direnv.vim",
  event = { "VimEnter", "DirChanged" },
  keys = {
    { "<leader>DD", "<cmd>DirenvExport<cr>", desc = "Load direnv" },
    { "<leader>DE", "<cmd>EditEnvrc<cr>", desc = "Edit .envrc" },
    { "<leader>De", "<cmd>EditDirenvrc<cr>", desc = "Edit global .direnvrc" },
  },
  init = function()
    -- It will not execute |direnv-commands-direnvexport| automatically if the value is `0`. Default: `1`.
    vim.g.direnv_auto = 1
    -- Select the command to open buffers to edit. Default: `'edit'`.
    vim.g.direnv_edit_mode = "edit"
    -- Stop echoing output from Direnv command. Default: `0`.
    vim.g.direnv_silent_load = 0
  end,
}
