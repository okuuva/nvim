---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require("conform")
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

local function expandFormatters(formatters)
  return function(bufnr)
    local result = {}
    for i = 1, #formatters do
      local formatter = formatters[i]
      if type(formatter) == "table" then
        result[i] = first(bufnr, unpack(formatter))
      else
        result[i] = formatter
      end
    end
    return result
  end
end

---@type LazyPluginSpec
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local util = require("conform.util")
    ---@type conform.setupOpts
    local opts = {
      formatters = {
        hujson = {
          meta = {
            url = "https://github.com/biomejs/biome",
            description = "A toolchain for web projects, aimed to provide functionalities to maintain them.",
          },
          command = util.from_node_modules("biome"),
          stdin = true,
          -- HACK: trick biome to treat hujson files as jsonc with --stdin-file-path
          -- since content is read from stdin it doesn't actually read the file passed with the flag but biome uses the
          -- file extension to detect the file type. hujson isn't supported while jsonc is, and the cli flags override
          -- any potential jsonc specific settings to follow hujson best practices
          args = {
            "format",
            "--json-formatter-indent-style=tab",
            "--json-formatter-indent-width=4",
            "--json-formatter-expand=always",
            "--json-formatter-trailing-commas=all",
            "--stdin-file-path",
            "hujson.jsonc",
          },
          cwd = util.root_file({
            "biome.json",
            "biome.jsonc",
          }),
        },
      },
      formatters_by_ft = {
        -- Conform will run multiple formatters sequentially
        -- Use a sub-list to run only the first available formatter
        bash = expandFormatters({ "shfmt", { "shellharden", "shellcheck" } }),
        fish = { "fish_indent" },
        go = expandFormatters({ { "goimports", "gofmt" } }),
        javascript = expandFormatters({ { "prettierd", "prettier" } }),
        hujson = { "hujson" },
        lua = { "stylua" },
        nix = { "alejandra" },
        python = expandFormatters({ { "darker", "isort" }, "black" }),
        ruby = { "rubocop" },
        sh = expandFormatters({ "shfmt", { "shellharden", "shellcheck" } }),
        toml = { "pyproject-fmt" },
        typescript = expandFormatters({ { "prettierd", "prettier" } }),
        yaml = { "yq" },
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
      return not util.root_file({ ".darker" })
    end
    require("conform.formatters.darker").condition = function()
      return util.root_file({ ".darker" })
    end
  end,
}
