---@type LazyPluginSpec
return {
  "0x00-ketsu/markdown-preview.nvim",
  cmd = {
    "MPToggle",
    "MPOpen",
    "MPClose",
    "MPRefresh",
  },
  ft = require("user.util").include_markdown_filetypes({ "wiki" }),
    -- stylua: ignore
    keys = {
      { "<leader>mt", "<cmd>MPToggle<cr>", desc = "Toggle" },
      { "<leader>mo", "<cmd>MPOpen<cr>", desc = "Open" },
      { "<leader>mc", "<cmd>MPClose<cr>", desc = "Close" },
      { "<leader>mr", "<cmd>MPRefresh<cr>", desc = "Refresh" },
    },
  opts = {
    glow = {
      -- When find executable path of `glow` failed (from PATH), use this value instead
      exec_path = "",
    },
    -- Markdown preview term
    term = {
      -- reload term when rendered markdown file changed
      reload = {
        enable = true,
        events = { "InsertLeave", "TextChanged" },
      },
      direction = "vertical", -- choices: vertical / horizontal
      keys = {
        close = { "q", "<Esc>" },
        refresh = "r",
      },
    },
  },
}
