-- Use bash since fish causes slowdowns
vim.opt.shell = "/usr/bin/env bash"

-- Set Python3 and Node paths, don't wanna use whatever is found from $PATH
-- Had to add Node path to PATH, setting the node_host_prog alone wasn't enough for whatever reason
local node_path = vim.env.HOME .. "/.local/share/nvm/v16.15.0/bin"
vim.env.PATH = node_path .. ":" .. vim.env.PATH
vim.g.node_host_prog = node_path .. "/neovim-node-host"
vim.g.python3_host_prog = vim.env.HOME .. "/.pyenv/versions/pynvim/bin/python3"

-- Do not load unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Use filetype plugin written in LUA
vim.g.do_filetype_lua = 1

require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.impatient") -- speedy gonzales startup
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
require("user.dapconfig")
require("user.dap-vt")
require("user.dap-ui")
require("user.pretty-fold")
require("user.scrollbar")
require("user.auto-session")
require("user.trouble")
-- require "user.autocommands"
