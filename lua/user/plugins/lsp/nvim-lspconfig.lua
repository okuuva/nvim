---@type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  version = "^2.5.0",
  event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
  keys = {
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    { "gO", vim.lsp.buf.document_symbol, desc = "List Document Symbols" },
    { "grl", vim.lsp.codelens.run, desc = "CodeLens Action" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
    { "<leader>ll", "<cmd>LspLog<cr>", desc = "Log" },
    { "<leader>lr", "<cmd>LspRestart<cr>", desc = "Restart" },
  },
  config = function()
    -- enable inlay hints by default
    vim.lsp.inlay_hint.enable()
  end,
  dependencies = {
    "b0o/schemastore.nvim", -- json schemas for jsonls
    "mrjones2014/codesettings.nvim",
    "lazydev.nvim",
    "blink.cmp",
    "nvim-lightbulb",
    "conform.nvim",
    "nvim-lint",
    "actions-preview.nvim",
    "imroc/kubeschema.nvim",
  },
}
