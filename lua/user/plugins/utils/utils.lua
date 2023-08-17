return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "b0o/schemastore.nvim", -- json schemas for jsonls
    lazy = true,
  },
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
      { "<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer" },
    },
  },
  {
    "mcauley-penney/tidy.nvim",
    config = true,
    event = "BufWritePre",
  },
  {
    "felipec/vim-sanegx",
    event = "VeryLazy",
  },
  {
    -- this is ostensibly unnecessary but decoupling cursorhold events from updatetime
    -- might still be a good idea.
    -- see https://github.com/antoinemadec/FixCursorHold.nvim/issues/13
    "antoinemadec/FixCursorHold.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
}
