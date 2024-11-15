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
  version = "^1.0.0",
  lazy = false,
  init = function()
    -- use almost the same sessionoptions as the plugin author
    -- https://github.com/olimorris/persisted.nvim#what-is-saved-in-the-session
    vim.o.sessionoptions = "buffers,curdir,folds,globals,winpos,winsize"
  end,
  opts = {
    should_save = should_autosave, -- function to determine if a session should be autosaved
    follow_cwd = false, -- change session file name to match current working directory if it changes
    use_git_branch = true, -- create session files based on the branch of the git enabled repository
    autoload = true, -- automatically load the session for the cwd on Neovim startup
    on_autoload_no_session = on_autoload_no_session, -- function to run when `autoload = true` but there is no session to load
    allowed_dirs = {
      "~/gits",
    }, -- table of dirs that the plugin will auto-save and auto-load from
  },
}
