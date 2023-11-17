return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local opts = {
      formatters_by_ft = {
        -- Conform will run multiple formatters sequentially
        -- Use a sub-list to run only the first available formatter
        bash = { "shfmt", { "shellharden", "shellcheck" } },
        fish = { "fish_indent" },
        go = { { "golines", "goimports", "gofmt" } },
        javascript = { { "prettierd", "prettier" } },
        lua = { "stylua" },
        python = { { "darker", "isort" }, "black" },
        sh = { "shfmt", { "shellharden", "shellcheck" } },
        ruby = { "rubocop" },
      },
      format_after_save = {
        lsp_fallback = true,
      },
      -- swap between these when debugging
      log_level = vim.log.levels.ERROR,
      -- log_level = vim.log.levels.TRACE,
    }
    require("conform").setup(opts)
    require("conform.formatters.black").condition = function()
      return not require("conform.util").root_file({ ".darker" })
    end
    require("conform.formatters.darker").condition = function()
      return require("conform.util").root_file({ ".darker" })
    end
  end,
}
