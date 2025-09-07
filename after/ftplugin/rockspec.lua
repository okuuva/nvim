-- Treat as Lua-ish but don’t attach LSP/formatter
vim.bo.commentstring = "-- %s"
vim.treesitter.language.register("lua", "rockspec")
