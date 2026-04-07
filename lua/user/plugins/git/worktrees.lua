local function on_create(path)
  -- Run post-create setup commands in the new worktree
  local cmds = {
    { "wt", "step", "copy-ignored" },
    { "gt", "track" },
  }
  for _, cmd in ipairs(cmds) do
    if vim.fn.executable(cmd[1]) == 1 then
      local result = vim.system(cmd, { cwd = path }):wait()
      if result.code == 0 then
        vim.notify(table.concat(cmd, " ") .. " succeeded", vim.log.levels.INFO)
      else
        vim.notify(
          table.concat(cmd, " ") .. " failed (exit " .. result.code .. "): " .. (result.stderr or ""),
          vim.log.levels.WARN
        )
      end
    else
      vim.notify(cmd[1] .. " not found, skipping " .. table.concat(cmd, " "), vim.log.levels.DEBUG)
    end
  end
end

---@type LazyPluginSpec
return {
  "afonsofrancof/worktrees.nvim",
  cmd = {
    "WorktreeCreate",
    "WorktreeDelete",
    "WorktreeSwitch",
  },
  opts = {
    -- Specify where to create worktrees relative to git common dir
    -- The common dir is the .git dir in a normal repo or the root dir of a bare repo
    base_path = "..", -- Parent directory of common dir

    -- Template for worktree folder names
    -- This is only used if you don't specify the folder name when creating the worktree
    path_template = "{branch}", -- Default: use branch name
    on_create = on_create,
    on_switch = function(_, path)
      on_create(path)
    end
  },
}
