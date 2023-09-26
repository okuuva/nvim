return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Conform will run multiple formatters sequentially
      -- Use a sub-list to run only the first available formatter
      bash = { "shfmt", { "shellharden", "shellcheck" } },
      fish = { "fish_indent" },
      go = { { "golines", "goimports", "gofmt" } },
      javascript = { { "prettierd", "prettier" } },
      lua = { "stylua" },
      python = { "isort", "black" },
      sh = { "shfmt", { "shellharden", "shellcheck" } },
      ruby = { "rubocop" },
    },
    format_on_save = {
      -- I recommend these options. See :help conform.format for details.
      lsp_fallback = true,
    },
    log_level = vim.log.levels.TRACE, -- ERROR by default, uncomment this for debugging
  },
}
