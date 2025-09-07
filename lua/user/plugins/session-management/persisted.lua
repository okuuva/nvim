local should_autosave = function()
  -- Do not save if we're just paging something
  if USING_PAGE then
    return false
  end

  -- throwaway buffer is a buffer that's not associated with any file
  -- doesn't matter if there's content or not, if it wasn't worth saving
  -- to the disc then it's not worth having a session saved for it
  local bufnr = vim.api.nvim_get_current_buf()
  local throwaway_buffer = vim.api.nvim_buf_get_name(bufnr) == ""
  local oil_open = vim.bo.filetype == "oil"
  local in_bare_repo = vim.fn.system("git rev-parse --is-bare-repository") == "true\n"
  if (throwaway_buffer or oil_open) and not in_bare_repo then
    return false
  end
  return true
end

return {
  "olimorris/persisted.nvim",
  version = "^2.0.0",
  lazy = false,
  priority = 900,
  init = function()
    -- use almost the same sessionoptions as the plugin author
    -- https://github.com/olimorris/persisted.nvim#what-is-saved-in-the-session
    vim.o.sessionoptions = "buffers,curdir,folds,globals,winpos,winsize"

    -- Hide intro message
    vim.o.shortmess = vim.o.shortmess .. "I"
  end,
  opts = {
    should_save = should_autosave, -- function to determine if a session should be autosaved
    follow_cwd = false, -- change session file name to match current working directory if it changes
    use_git_branch = false, -- create session files based on the branch of the git enabled repository
    autoload = not USING_PAGE, -- automatically load the session for the cwd on Neovim startup
    on_autoload_no_session = function()
      local ok, oil = pcall(require, "oil")
      if ok then
        oil.open()
      end
    end,
    allowed_dirs = {
      "~/gits",
    }, -- table of dirs that the plugin will auto-save and auto-load from
    ignored_dirs = {
      { "~/gits", exact = true },
    },
  },
}
