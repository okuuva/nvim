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
    { "<leader>jj",
      function()
        toggle_terminal("jjui", { win = { style = "terminal_fullscreen" } })
      end,
      desc = "Jujutsu"
    },
  },
  ---@type snacks.Config
  opts = {
    terminal = {
      shell = "fish",
    },
    styles = {
      terminal = {
        keys = {
          ["<C-q>"] = "hide",
          term_normal_alt = {
            "<C-q>",
            function(self)
              vim.cmd("stopinsert")
            end,
            mode = "t",
            desc = "<C-q> to normal mode",
          },
        },
      },
      terminal_fullscreen = {
        style = "terminal",
        height = 0,
        width = 0,
      },
    },
  },
}
