local mason_version = "^2.0.0"

local ensure_installed = {
  -- lsp
  "basedpyright",
  "bash-language-server",
  "biome",
  "copilot-language-server",
  "docker-compose-language-service",
  "dockerfile-language-server",
  "fish-lsp",
  "gopls",
  "helm-ls",
  "html-lsp",
  "json-lsp",
  "lua-language-server",
  "marksman",
  "ruff",
  "taplo",
  "terraform-ls",
  "tflint",
  "tombi",
  "vim-language-server",
  "yaml-language-server",

  -- dap
  "bash-debug-adapter",
  "debugpy",
  "delve",
  "js-debug-adapter",
  "local-lua-debugger-vscode",

  -- linters
  "gitleaks",
  "kube-linter",
  "tflint",
  "tfsec",
  "yamllint",

  -- formatters
  "black", -- TODO: replace with ruff
  "darker", -- TODO: replace with ruff
  "goimports",
  "golines",
  "prettierd",
  "stylua",
  "yamlfmt",
}

---@type table<LazyPluginSpec>
return {
  {
    "mason-org/mason.nvim",
    lazy = false, -- lazy loading mason is not recommended
    priority = 500,
    cmd = "Mason",
    keys = {
      { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" },
    },
    version = mason_version,
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    version = mason_version,
    lazy = false,
    priority = 499,
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "BufReadPre",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = ensure_installed,
    },
  },
}
