local on_autoload_no_session = function()
  -- need to pass true (on_vimenter) so that alpha clears the unnamed buffer vim creates at start
  require("alpha").start(true)
end

local after_source = function(session)
  local message = "Autoloaded session"
  if session then
    message = "Loaded session " .. session.name
  end

  vim.defer_fn(function()
    vim.notify(message, vim.log.levels.INFO, { title = "Session manager" })
  end, 0)
end

require("persisted").setup({
  save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
  command = "VimLeavePre", -- the autocommand for which the session is saved
  silent = false, -- silent nvim message when sourcing session file
  use_git_branch = false, -- create session files based on the branch of the git enabled repository
  branch_separator = "_", -- string used to separate session directory name from branch name
  autosave = true, -- automatically save session files when exiting Neovim
  autoload = true, -- automatically load the session for the cwd on Neovim startup
  on_autoload_no_session = on_autoload_no_session, -- function to run when `autoload = true` but there is no session to load
  allowed_dirs = {
    "~/gits",
  }, -- table of dirs that the plugin will auto-save and auto-load from
  ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
  before_save = nil, -- function to run before the session is saved to disk
  after_save = nil, -- function to run after the session is saved to disk
  after_source = after_source, -- function to run after the session is sourced
  telescope = { -- options for the telescope extension
    before_source = nil, -- function to run before the session is sourced via telescope
    after_source = after_source, -- function to run after the session is sourced via telescope
  },
})
