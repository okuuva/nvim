-- Unset the 'last search pattern' register by hitting return
-- Set like this since which-key does not support empty mode (aka :map) but don't want to have
-- a single generic key binding done somewhere else
vim.api.nvim_set_keymap("", "<CR>", ":noh<CR>", { noremap = true, silent = true })

---@module "which-key"
---@type wk.Spec
local mappings = {
  { "<leader>gc", require("user.util").process_graphite_share_stack_string, desc = "Clean Graphite share links" },
  { "<leader>L", "<cmd>Lazy<cr>", desc = "Lazy", nowait = true, remap = false },
  { "<leader>N", group = "Neoconf", nowait = true, remap = false },
  { "<leader>P", group = "Pastebin", nowait = true, remap = false },
  { "<leader>R", group = "IronRepl", nowait = true, remap = false },
  { "<leader>T", group = "TreeSitter", nowait = true, remap = false },
  { "<leader>a", group = "AI", nowait = true, remap = false },
  { "<leader>b", group = "Buffers", nowait = true, remap = false },
  { "<leader>d", group = "Diagnostics", nowait = true, remap = false },
  { "<leader>g", group = "Git", nowait = true, remap = false },
  { "<leader>gL", group = "GitLink", nowait = true, remap = false },
  { "<leader>gt", group = "Toggle", nowait = true, remap = false },
  { "<leader>h", group = "Harpoon", nowait = true, remap = false },
  { "<leader>l", group = "LSP", nowait = true, remap = false },
  { "<leader>m", group = "Markdown Preview", nowait = true, remap = false },
  { "<leader>n", group = "Notifications", nowait = true, remap = false },
  { "<leader>o", group = "Obsidian", nowait = true, remap = false },
  { "<leader>q", "<cmd>qa!<CR>", desc = "Quit", nowait = true, remap = false },
  { "<leader>s", group = "Search", nowait = true, remap = false },
  { "<leader>t", group = "Neotest", nowait = true, remap = false },
  { "<leader>w", "<cmd>w<cr>", desc = "Write", nowait = true, remap = false },
  { "<leader>z", group = "Zen Mode", nowait = true, remap = false },
  {
    mode = { "x" },
    { "<leader>P", group = "Pastebin" },
    { "<leader>a", group = "AI" },
    { "<leader>g", group = "Git" },
    { "<leader>gL", group = "GitLink" },
    { "<leader>gl", group = "Gitlab" },
    { "<leader>o", group = "Obsidian" },
    { "<leader>ss", ":<C-u>'<,'>sort<cr>", desc = "Sort" },
  },
  {
    mode = { "v" },
    { "<", "<gv", desc = "Indent left and stay in indent mode", noremap = true, silent = true },
    { ">", ">gv", desc = "Indent right and stay in indent mode", noremap = true, silent = true },
  },
  { "<leader>gla", group = "Assignee" },
  { "<leader>gll", group = "Labels" },
  { "<leader>glr", group = "Reviewer" },
}

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "mini.icons",
    "nvim-web-devicons",
  },
  ---@type wk.Opts
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "classic",
    ---@type wk.Win.opts
    win = {
      border = "rounded",
      title = true,
      title_pos = "center",
      wo = {
        winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
    },
    ---@type wk.Spec
    spec = mappings,
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
}
