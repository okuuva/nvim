return {
  "mfussenegger/nvim-lint",
  config = function()
    require("lint").linters_by_ft = {
      markdown = { "vale" },
      bash = { "shellcheck" },
      sh = { "shellcheck" },
      sql = { "sqlfluff" },
    }
    local sqlfluff = require("lint").linters.sqlfluff
    sqlfluff.args = {
      "lint",
      "--format=json",
      "--dialect=postgres",
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
