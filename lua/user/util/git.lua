local Job = require("plenary.job")
local M = {}

-- @param? remote string
-- @param? base_branch string
local function rebase(remote, base_branch)
  remote = remote or "origin"
  base_branch = base_branch or "main"
  return Job:new({
    command = "git",
    args = { "rebase", remote .. "/" .. base_branch },
    cwd = vim.fn.getcwd(),
  })
end

local function fetch()
  return Job:new({
    command = "git",
    args = { "fetch" },
    cwd = vim.fn.getcwd(),
  })
end

function M.fetch()
  fetch():sync()
end

function M.rebase()
  local job = fetch()
  job:and_then_on_success(rebase())

  job:sync()
  if job.code ~= 0 then
    vim.notify("Rebase failed")
    return
  end
  vim.notify("Branch/worktree rebased")
  require("user.util").reload_buffers()
end

return M
