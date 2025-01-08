---@type wk.Spec
local mappings = {
  { "<leader>C", "<cmd>close<CR>", desc = "Close split", nowait = true, remap = false },
  { "<leader>L", "<cmd>Lazy<cr>", desc = "Lazy", nowait = true, remap = false },
  { "<leader>N", group = "Neoconf", nowait = true, remap = false },
  { "<leader>R", group = "IronRepl", nowait = true, remap = false },
  { "<leader>S", group = "Split", nowait = true, remap = false },
  { "<leader>SS", "<cmd>vsplit<cr>", desc = "Vertical split", nowait = true, remap = false },
  { "<leader>SH", "<cmd>split<cr>", desc = "Horizontal split", nowait = true, remap = false },
  { "<leader>T", group = "TreeSitter", nowait = true, remap = false },
  { "<leader>b", group = "Buffers", nowait = true, remap = false },
  { "<leader>d", group = "Diagnostics", nowait = true, remap = false },
  { "<leader>g", group = "Git", nowait = true, remap = false },
  { "<leader>gL", group = "GitLink", nowait = true, remap = false },
  { "<leader>gl", group = "Gitlab", nowait = true, remap = false },
  { "<leader>gt", group = "Toggle", nowait = true, remap = false },
  { "<leader>h", group = "Harpoon", nowait = true, remap = false },
  { "<leader>l", group = "LSP", nowait = true, remap = false },
  { "<leader>m", group = "Markdown Preview", nowait = true, remap = false },
  { "<leader>n", group = "Neotest", nowait = true, remap = false },
  { "<leader>nt", group = "Toggle", nowait = true, remap = false },
  { "<leader>o", group = "Obsidian", nowait = true, remap = false },
  { "<leader>p", group = "Pastebin", nowait = true, remap = false },
  { "<leader>q", "<cmd>qa!<CR>", desc = "Quit", nowait = true, remap = false },
  { "<leader>s", group = "Search", nowait = true, remap = false },
  { "<leader>w", "<cmd>w<cr>", desc = "Write", nowait = true, remap = false },
  {
    mode = { "x" },
    { "<leader>g", group = "Git" },
    { "<leader>gL", group = "GitLink" },
    { "<leader>gl", group = "Gitlab" },
    { "<leader>o", group = "Obsidian" },
    { "<leader>p", group = "Pastebin" },
    { "<leader>s", ":<C-u>'<,'>sort<cr>", desc = "Sort" },
  },
  { "<leader>gla", group = "Assignee" },
  { "<leader>gll", group = "Labels" },
  { "<leader>glr", group = "Reviewer" },
}

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  ---@class wk.Opts
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "classic",
    ---@type wk.Win.opts
    win = {
      ---@type window_border
      border = "rounded",
      title = true,
      title_pos = "center",
      -- Additional vim.wo and vim.bo options
      bo = {},
      ---@type window_options
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
