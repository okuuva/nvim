function AI_Check_disabled_patters()
  -- local success, forbidden_patters = pcall(require, "user.config.local.ai")
  -- forbidden_patters = success and forbidden_patters or {}
  -- local Util = require("user.util")
  -- local path = Util.get_root()
  -- for _, pattern in ipairs(forbidden_patters) do
  --   if path:find(pattern) then
  --     return false
  --   end
  -- end
  return false
end

return {
  "zbirenbaum/copilot.lua",
  event = "VeryLazy",
  cmd = "Copilot",
  cond = AI_Check_disabled_patters(),
  opts = {
    panel = {
      enabled = false,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>",
      },
      layout = {
        position = "bottom", -- | top | left | right
        ratio = 0.4,
      },
    },
    suggestion = {
      enabled = false,
      auto_trigger = false,
      debounce = 75,
      keymap = {
        accept = "<M-l>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      yaml = false,
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
    copilot_node_command = "node", -- Node.js version must be > 16.x
    server_opts_overrides = {},
  },
}
