---@param cmd string?
---@param opts snacks.terminal.Opts
local function toggle_terminal(cmd, opts)
  local term, created = Snacks.terminal.get(cmd, opts)
  if term and not created then
    term:toggle()
  end
end

vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    for _, term in ipairs(Snacks.terminal.list()) do
      if term ~= nil then
        vim.fn.chansend(vim.bo[term.buf].channel, {
          "cd " .. vim.fn.getcwd() .. "\r\n",
          "clear\r\n",
        })
      end
    end
  end,
})

---@type LazyPluginSpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<C-a>", toggle_terminal, desc = "Toggle Terminal", mode = { "i", "n", "t" } },
  },
  ---@type snacks.Config
  opts = {
    terminal = {
      shell = "fish",
    },
  },
}
