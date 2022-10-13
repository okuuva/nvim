local servers = {
  "bashls",
  "dockerls",
  "gopls",
  "yamlls",
  "html",
  "pylsp",
  "jsonls",
  "sumneko_lua",
  "volar",
}

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  -- A list of servers to automatically install if they're not already installed. Example: { "rust-analyzer@nightly", "sumneko_lua" }
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = servers,

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = true,
})

local lspconfig = require("lspconfig")

mason_lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name)
    local opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    }
    local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server_name)
    if has_custom_opts then
      opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
    end
    lspconfig[server_name].setup(opts)
  end,
})
