local M = {}


--- Parse git-common-dir and return the bare repo root if cwd is inside a bare repo.
---@return string|nil
local function parse_bare_root()
  local common_dir = vim.trim(vim.fn.system("git rev-parse --git-common-dir"))
  if vim.v.shell_error ~= 0 or common_dir == ".git" then
    return nil
  end

  local root = vim.fn.fnamemodify(common_dir, ":h")
  if vim.trim(vim.fn.system("git -C " .. vim.fn.shellescape(root) .. " rev-parse --is-bare-repository")) == "true" then
    return root
  end

  return nil
end

--- Check if cwd is inside a bare git repo (either at the root or in a worktree).
---@return boolean
function M.in_bare_repo()
  if vim.trim(vim.fn.system("git rev-parse --is-bare-repository")) == "true" then
    return true
  end

  return parse_bare_root() ~= nil
end

--- If cwd is in a worktree of a bare repo, return the bare repo root path.
--- If cwd is already at the bare repo root, return nil (no need to cd).
---@return string|nil
function M.bare_repo_root()
  return parse_bare_root()
end

return M
