local mason_version = "^1.0.0"

---@type table<LazyPluginSpec>
return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" },
    },
    version = mason_version,
    opts = {
      ensure_installed = {
        "basedpyright",
        "bash-language-server",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "fish-lsp",
        "gitleaks",
        "gopls",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "marksman",
        "prettierd",
        "ruff",
        "taplo",
        "vim-language-server",
        "vue-language-server",
        "yaml-language-server",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    version = mason_version,
    dependencies = { "mason.nvim" },
    opts = {},
  },
}
