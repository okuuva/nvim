return {
  "b0o/schemastore.nvim", -- json schemas for jsonls
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  },
  {
    "mcauley-penney/tidy.nvim",
    config = true,
    event = "BufWritePre",
  },
  "felipec/vim-sanegx",
}
