local linkables = {
  ".gitlab.nvim",
}

---@type LazyPluginSpec
return {
  -- "polarmutex/git-worktree.nvim",
  -- version = "^2.0.0",
  "rbmarliere/git-worktree.nvim",
  commit = "ae94f27",
  dependencies = {
    "plenary.nvim",
    "telescope.nvim",
  },
  keys = {
    {
      "<leader>gw",
      function()
        require("telescope").extensions.git_worktree.git_worktree()
      end,
      desc = "List Worktrees",
    },
    {
      "<leader>gW",
      function()
        require("telescope").extensions.git_worktree.create_git_worktree({ prefix = "../" })
      end,
      desc = "Create Worktree",
    },
  },
  config = function()
    ---@type GitWorktreeConfig
    vim.g.git_worktree = {
      change_directory_command = "cd",
      update_on_change = true,
      update_on_change_command = "e .",
      clearjumps_on_change = true,
      confirm_telescope_deletions = false,
      autopush = true,
    }
    local Hooks = require("git-worktree.hooks")
    local config = require("git-worktree.config")
    local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

    Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
      vim.notify("Moved from " .. prev_path .. " to " .. path)
      update_on_switch(path, prev_path)
    end)

    Hooks.register(Hooks.type.DELETE, function()
      vim.cmd(config.update_on_change_command)
    end)
  end,
}
