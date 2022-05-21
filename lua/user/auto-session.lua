-- Use a protected call so we don't error out on first use
local status_ok, auto_session = pcall(require, "auto-session")
if not status_ok then
  return
end

-- Recommended defaults by auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

auto_session.setup({
  log_level = "info",
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_suppress_dirs = { "~", "~/gits" },
  auto_session_use_git_branch = nil,
  bypass_session_save_file_types = { "gitcommit" },
  post_restore_cmds = { "NvimTreeOpen", "wincmd l" },
})

local status_ok, telescope = pcall(require, "telescope")
if status_ok then
  telescope.load_extension("session-lens")
end

local status_ok, session_lens = pcall(require, "session-lens")
if not status_ok then
  return
end

session_lens.setup()
