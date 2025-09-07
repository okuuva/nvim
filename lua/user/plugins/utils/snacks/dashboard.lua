local function BdeleteAndCloseTabIfNotLast()
  Snacks.bufdelete({ force = true })

  local tabpages = vim.api.nvim_list_tabpages()
  -- close tab if it's not the last one
  if #tabpages > 1 then
    vim.cmd("tabclose")
  end
end

---@type LazyPluginSpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>c",  BdeleteAndCloseTabIfNotLast,       desc = "Close Buffer" },
    { "<leader>D",  function() Snacks.dashboard() end, desc = "Dashboard" },
  },
  ---@type snacks.Config
  opts = {
    -- TODO: figure out how to hide cursor on dashboard
    -- it was visible on alpha as well but would be cool to hide it
    -- see:
    -- - https://github.com/goolord/alpha-nvim/discussions/75
    -- - https://github.com/goolord/alpha-nvim/issues/208
    -- - https://github.com/neovim/neovim/issues/3688#issuecomment-574544618

    ---@type snacks.dashboard.Config
    dashboard = {
      enabled = false,
      preset = {
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "t", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "e", desc = "Edit Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
          { icon = " ", key = "w", desc = "List Git Worktrees", action = "<leader>gw" },
          { icon = " ", key = "W", desc = "Create Git Worktree", action = "<leader>gW" },
          { icon = " ", key = "s", desc = "Restore Session", action = ":SessionSelect" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = "󰜺 ", key = "c", desc = "Close Dashboard", action = ":lua Snacks.bufdelete()" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
