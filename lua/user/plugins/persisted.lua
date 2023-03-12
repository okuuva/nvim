local on_autoload_no_session = function()
  -- need to pass true (on_vimenter) so that alpha clears the unnamed buffer vim creates at start
  require("alpha").start(true)
end

local should_autosave = function()
  -- do not autosave if the alpha dashboard is the current filetype
  if vim.bo.filetype == "alpha" then
    return false
  end
  return true
end

return {
  "olimorris/persisted.nvim",
  init = function()
    -- use same sessionoptions as the plugin author
    -- https://github.com/olimorris/persisted.nvim#what-is-saved-in-the-session
    vim.o.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"
  end,
  opts = {
    save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
    silent = false, -- silent nvim message when sourcing session file
    use_git_branch = false, -- create session files based on the branch of the git enabled repository
    autosave = true, -- automatically save session files when exiting Neovim
    should_autosave = should_autosave, -- function to determine if a session should be autosaved
    autoload = true, -- automatically load the session for the cwd on Neovim startup
    on_autoload_no_session = on_autoload_no_session, -- function to run when `autoload = true` but there is no session to load
    follow_cwd = true, -- change session file name to match current working directory if it changes
    allowed_dirs = {
      "~/gits",
    }, -- table of dirs that the plugin will auto-save and auto-load from
    ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
    telescope = { -- options for the telescope extension
      reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
    },
  },
}
