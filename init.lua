vim.g.python3_host_prog = vim.env.HOME .. "/.pyenv/versions/pynvim/bin/python3"
vim.g.node_host_prog = vim.env.HOME .. "/bin/neovim-node-host"

vim.g.do_filetype_lua = 1 -- use new filetype.lua

require("user.impatient") -- speedy gonzales startup
require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.material")
require("user.colorscheme")
require("user.cmp")
require("user.lsp")
require("user.telescope")
require("user.treesitter")
require("user.autopairs")
require("user.comment")
require("user.gitsigns")
require("user.nvim-tree")
require("user.bufferline")
require("user.lualine")
require("user.toggleterm")
require("user.project")
require("user.indentline")
require("user.alpha")
require("user.whichkey")
require("user.filetype")
require("user.autosave")
-- require "user.autocommands"
