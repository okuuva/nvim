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
  }
}
