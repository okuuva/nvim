local git = require("user.util.git")

local should_autosave = function()
  -- Do not save if we're just paging something
  if ACTING_AS_PAGER then
    return false
  end

  -- throwaway buffer is a buffer that's not associated with any file
  -- doesn't matter if there's content or not, if it wasn't worth saving
  -- to the disc then it's not worth having a session saved for it
  local bufnr = vim.api.nvim_get_current_buf()
  local throwaway_buffer = vim.api.nvim_buf_get_name(bufnr) == ""
  local oil_open = vim.bo.filetype == "oil"
  if (throwaway_buffer or oil_open) and not git.in_bare_repo() then
    return false
  end
  return true
end

---@type LazyPluginSpec
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

    -- If we're in a worktree of a bare repo, cd to the bare repo root so
    -- that persisted.nvim uses a single session for the whole bare repo.
    -- The session records curdir, so the last-active worktree is restored.
    local bare_root = git.bare_repo_root()
    if bare_root then
      vim.api.nvim_set_current_dir(bare_root)
    end

    -- :restart (neovim 0.12+) calls :qall internally, which fires
    -- VimLeavePre and may overwrite the session after splits are gone.
    -- Save explicitly before restart, then stop persisted so the
    -- VimLeavePre handler doesn't clobber the good save.
    vim.keymap.set("ca", "restart", function()
      if vim.fn.getcmdline() == "restart" then
        return 'lua require("persisted").save({ force = true }); require("persisted").stop() <bar> restart lua vim.g.persisted_defer_load = true'
      end
      return "restart"
    end, { expr = true })
  end,
  opts = {
    should_save = should_autosave, -- function to determine if a session should be autosaved
    follow_cwd = false, -- change session file name to match current working directory if it changes
    use_git_branch = false, -- create session files based on the branch of the git enabled repository
    autoload = not ACTING_AS_PAGER, -- automatically load the session for the cwd on Neovim startup
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
