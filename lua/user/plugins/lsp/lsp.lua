-- heavily inspired by LazyVim:
-- https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins/lsp/init.lua
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- stylua: ignore
    keys = {
      -- Code action gets triggered with <leader>la via actions-preview plugin
      { "<leader>lf", function() _LSP_FORMAT() end, desc = "Format" },
      { "<leader>lh", vim.lsp.buf.hover, desc = "Hover" },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
      { "<leader>ll", vim.lsp.codelens.run, desc = "CodeLens Action" },
      { "<leader>lo", "<cmd>LspLog<cr>", desc = "Log" },
    },
    dependencies = {
      "b0o/schemastore.nvim", -- json schemas for jsonls
      "neoconf.nvim",
      "neodev.nvim",
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "nvim-lightbulb",
      "conform.nvim",
      "nvim-lint",
      "actions-preview.nvim",
      {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        -- stylua: ignore
        keys = {
          { "<leader>dv", function() require("lsp_lines").toggle() end, desc = "Toggle virtual line diagnostics", },
        },
        config = true,
      }, -- virtual line diagnostics
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
        virtual_lines = {
          only_current_line = true,
        },
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
                  return lspconfig.util.find_git_ancestor(fname)
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

      local diagnostic_signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }

      for _, sign in ipairs(diagnostic_signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      vim.diagnostic.config(opts.diagnostics)

      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- nvim-ufo folding settings
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

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

      -- temp fix for lspconfig rename
      -- https://github.com/neovim/nvim-lspconfig/pull/2439
      local mappings = require("mason-lspconfig.mappings.server")
      if not mappings.lspconfig_to_package.lua_ls then
        mappings.lspconfig_to_package.lua_ls = "lua-language-server"
        mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
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
  },
}
