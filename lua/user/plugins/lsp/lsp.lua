-- TODO: rewrite from scratch
-- this is so messy that it's hard to do any changes, should take a look how kickstart does things

-- heavily inspired by LazyVim:
-- https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins/lsp/init.lua
---@type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
  keys = {
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    { "gO", vim.lsp.buf.document_symbol, desc = "List Document Symbols" },
    { "<leader>lf", function() _LSP_FORMAT() end, desc = "Format" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
    { "<leader>ll", vim.lsp.codelens.run, desc = "CodeLens Action" },
    { "<leader>lO", "<cmd>LspLog<cr>", desc = "Log" },
    { "<leader>lr", "<cmd>LspRestart<cr>", desc = "Restart" },
  },
  dependencies = {
    "b0o/schemastore.nvim", -- json schemas for jsonls
    "neoconf.nvim",
    "lazydev.nvim",
    "mason-lspconfig.nvim",
    "blink.cmp",
    "nvim-lightbulb",
    "conform.nvim",
    "nvim-lint",
    "actions-preview.nvim",
  },
  ---@class PluginLspOpts
  opts = {
    -- options for vim.diagnostic.config()
    ---@class vim.diagnostic.Opts
    diagnostics = {
      underline = true,
      virtual_text = false,
      virtual_lines = {
        current_line = true,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
      update_in_insert = false,
      severity_sort = true,
    },
    -- do not automatically format on save
    autoformat = false,
    -- options for vim.lsp.buf.format
    -- `bufnr` and `filter` is handled by the LazyVim formatter,
    -- but can be also overridden when specified
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    -- LSP Server Settings
    ---@type lspconfig.options
    servers = require("user.plugins.lsp.servers.configs"),
    -- you can do any additional lsp server setup here
    -- return true if you don't want this server to be setup with lspconfig
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    setup = {
      -- example to setup with typescript.nvim
      -- tsserver = function(_, opts)
      --   require("typescript").setup({ server = opts })
      --   return true
      -- end,
      -- Specify * to use this function as a fallback for any server
      -- ["*"] = function(server, opts) end,
      fuzzy_ruby_ls = function()
        local lspconfig = require("lspconfig")
        local configs = require("lspconfig.configs")
        if not configs.fuzzy_ruby_ls then
          configs.fuzzy_ruby_ls = {
            default_config = {
              cmd = { "fuzzy_ruby_ls" },
              filetypes = { "ruby" },
              root_dir = function(fname)
                return vim.fs.dirname(vim.fn.find(".git", { path = fname, upward = true })[1])
              end,
              init_options = {
                allocationType = "ram",
                indexGems = true,
                reportDiagnostics = true,
              },
            },
          }
        end
      end,
    },
  },
  ---@param opts PluginLspOpts
  config = function(_, opts)
    -- setup autoformat
    require("user.plugins.lsp.util.format").autoformat = opts.autoformat
    -- setup formatting and keymaps
    require("user.util").on_attach(function(client, buffer)
      require("user.plugins.lsp.util.format").on_attach(client, buffer)
      -- require("user.plugins.lsp.util.keymaps").on_attach(client, buffer)
    end)

    vim.diagnostic.config(opts.diagnostics)

    -- enable inlay hints by default
    vim.lsp.inlay_hint.enable()

    -- nvim-ufo folding settings
    local capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    }
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
    local servers = opts.servers

    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, servers[server] or {})

      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end
      require("lspconfig")[server].setup(server_opts)
    end

    local mlsp = require("mason-lspconfig")
    local available = mlsp.get_available_servers()

    local ensure_installed = {} ---@type string[]
    for server, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
        if server_opts.mason == false or not vim.tbl_contains(available, server) then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end
    end

    require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
    require("mason-lspconfig").setup_handlers({ setup })
  end,
}
