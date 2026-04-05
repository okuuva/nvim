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
    { "<leader>li", "<cmd>checkhealth lsp<cr>", desc = "Info" },
    { "<leader>ll", function() vim.cmd.tabnew(vim.lsp.log.get_filename()) end, desc = "Log" },
    { "<leader>lr", "<cmd>lsp restart *<cr>", desc = "Restart" },
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
