---@type snacks.win | nil
local toggle_term = nil

-- save term on init, so that it can cd automatically along with neovim
local function toggle_terminal()
  local created
  if toggle_term == nil then
    toggle_term, created = Snacks.terminal.get(nil, {
      cwd = Snacks.git.get_root(),
      auto_insert = true,
      auto_close = false,
    })
    if not created then
      vim.notify("Failed to create toggle term", "error")
    end
    return
  end
  toggle_term:toggle()
end

vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    if toggle_term == nil then
      return
    end
    vim.fn.chansend(vim.bo[toggle_term.buf].channel, {
      "cd " .. vim.fn.getcwd() .. "\r\n",
      "clear\r\n",
    })
  end,
})

---@type LazyPluginSpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>ä", toggle_terminal, desc = "Toggle Terminal" },
  },
  ---@type snacks.Config
  opts = {
    terminal = {
      shell = "fish",
    },
  },
}
