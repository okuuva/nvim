-- set nvr as git editor
if vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'"
end

-- add Node path to PATH, setting the node_host_prog alone isn't enough for whatever reason
local node_path = vim.env.HOME .. "/.local/share/nvm/v18.14.2/bin"
vim.env.PATH = node_path .. ":" .. vim.env.PATH


local check_alpine = function()
  local os = vim.loop.os_uname().version
  if os:find("Alpine") or os:find("alpine") then
    return true
  end
  return false
end

local settings = {
  alpine_linux = check_alpine, -- check if we're running on Alpine Linux (meaning musl)
  do_filetype_lua = 1, -- use filetype plugin written in LUA
  loaded_netrw = 1, -- disable netrw
  loaded_netrwPlugin = 1, -- I mean it
  loaded_perl_provider = 0, -- do not load perl provider
  loaded_ruby_provider = 0, -- do not load ruby provider
  node_host_prog = node_path .. "/neovim-node-host",
  python3_host_prog = vim.env.HOME .. "/.pyenv/versions/pynvim/bin/python3",
  vimsyn_maxlines = 256, -- limit syntax highlighting to speed up scrolling
  vimsyn_minlines = 16, -- limit syntax highlighting to speed up scrolling
}

for k, v in pairs(settings) do
  vim.g[k] = v
end

local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 2, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  cursorline = true, -- highlight the current line
  expandtab = true, -- convert tabs to spaces
  fillchars = {
    vert = " ",
    fold = " ",
    foldopen = "",
    foldsep = " ",
    foldclose = "",
  },
  fileencoding = "utf-8", -- the encoding written to a file
  foldcolumn = "1", -- fold column width
  foldenable = true, -- no fold to be applied when open a file
  foldexpr = "nvim_treesitter#foldexpr()", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
  foldmethod = "expr", -- folding, set to "expr" for treesitter based folding
  guifont = "monospace:h17", -- the font used in graphical neovim applications
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  number = true, -- set numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  pumheight = 10, -- pop up menu height
  relativenumber = true, -- set relative numbered lines
  scrolloff = 8, -- is one of my fav
  shell = "/usr/bin/env bash", -- Use bash since fish causes slowdowns
  shiftwidth = 4, -- the number of spaces inserted for each indentation
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  sidescrolloff = 8,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  synmaxcol = 300, -- speed up scrolling a bit by disabling syntax highlighting on very long lines
  tabstop = 4, -- insert 4 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  wrap = false, -- display lines as one long line
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
