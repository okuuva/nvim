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

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local opts = {
      formatters_by_ft = {
        -- Conform will run multiple formatters sequentially
        -- Use a sub-list to run only the first available formatter
        bash = expandFormatters({ "shfmt", { "shellharden", "shellcheck" } }),
        fish = { "fish_indent" },
        go = expandFormatters({ { "goimports", "gofmt" } }),
        javascript = expandFormatters({ { "prettierd", "prettier" } }),
        lua = { "stylua" },
        python = expandFormatters({ { "darker", "isort" }, "black" }),
        sh = expandFormatters({ "shfmt", { "shellharden", "shellcheck" } }),
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
