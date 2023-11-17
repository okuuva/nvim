local linkables = {
  ".direnv",
  ".gitlab.nvim",
}

return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "plenary.nvim",
    "telescope.nvim",
  },
  keys = {
    {
      "<leader>gw",
      function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end,
      desc = "List Worktrees",
    },
    {
      "<leader>gW",
      function()
        require("telescope").extensions.git_worktree.create_git_worktree()
      end,
      desc = "Create Worktree",
    },
  },
  config = function()
    local Worktree = require("git-worktree")
    Worktree.setup()

    Worktree.on_tree_change(function(op, metadata)
      if op ~= Worktree.Operations.Create then
        return
      end

      local repo_root_path = vim.fn.getcwd() .. "/../"
      local worktree_path = repo_root_path .. metadata.path
      local envrc_path = repo_root_path .. ".envrc"
      if vim.fn.filereadable(envrc_path) then
        vim.notify("Copying .envrc to " .. worktree_path)
        os.execute("cp " .. envrc_path .. " " .. worktree_path)
      end
      for _, filename in ipairs(linkables) do
        local filepath = repo_root_path .. filename
        if vim.fn.filereadable(filepath) then
          vim.notify("Linking " .. filename .. " to " .. worktree_path)
          os.execute("ln -s " .. filepath .. " " .. worktree_path .. "/" .. filename)
        end
      end
    end)
  end,
}
