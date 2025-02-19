-- set nvr as git editor
if vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'"
end

local check_alpine = function()
  local os = vim.loop.os_uname().version
  if os:find("Alpine") or os:find("alpine") then
    return true
  end
  return false
end

NIX_BIN_DIR = "/run/current-system/sw/bin"
vim.env.PATH = NIX_BIN_DIR .. ":" .. vim.env.PATH

XDG_DATA_HOME = vim.env.XDG_DATA_HOME or (vim.env.HOME .. "/.local/share")
MISE_DATA_DIR = vim.env.MISE_DATA_DIR or (XDG_DATA_HOME .. "/mise")
MISE_SHIM_DIR = MISE_DATA_DIR .. "/shims"

vim.env.PATH = MISE_SHIM_DIR .. ":" .. vim.env.PATH

vim.env.CARGO_NET_GIT_FETCH_WITH_CLI = "true"

local settings = {
  alpine_linux = check_alpine, -- check if we're running on Alpine Linux (meaning musl)
  do_filetype_lua = 1, -- use filetype plugin written in LUA
  loaded_netrw = 1, -- disable netrw
  loaded_netrwPlugin = 1, -- I mean it
  loaded_perl_provider = 0, -- do not load perl provider
  mapleader = " ",  -- set <space> as <leader>
  maplocalleader = " ", -- set <space> as <localleader>
  python3_host_prog = NIX_BIN_DIR .. "/nvim-python3",
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
  diffopt = {
    "filler", -- show filler lines to keep the text in sync with a window with added lines in the same position
    "vertical", -- start diff in vertical mode by default
    "closeoff", -- run :diffoff for the last window in the tab if a diff window was closed
    "hiddenoff", -- do not use diff mode for a buffer when it becomes hidden
    "internal", -- use the internal diff library
    "indent-heuristic", -- use the indent heuristic for the internal diff library
    "algorithm:histogram", -- like patience but faster
  },
  expandtab = true, -- convert tabs to spaces
  fileencoding = "utf-8", -- the encoding written to a file
  fillchars = {
    eob = " ",
    fold = " ",
    foldopen = "",
    foldsep = " ",
    foldclose = "",
    vert = " ",
  },
  foldcolumn = "1", -- fold column width
  foldenable = true, -- no fold to be applied when open a file
  foldexpr = "v:lua.vim.treesitter.foldexpr()", -- use treesitter for folding
  foldlevel = 99, -- make sure no folds are closed when opening a file
  foldlevelstart = 99, -- make sure no folds are closed when opening a file
  foldmethod = "expr", -- folding, set to "expr" for lsp/treesitter based folding
  foldtext = "", -- set to empty string to the line is displayed normally with highlighting and no line wrapping
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
  showtabline = 0, -- never show tabs
  sidescrolloff = 8,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  startofline = true, -- commands move the cursor to the first non-blank character of the line
  swapfile = false, -- creates a swapfile
  synmaxcol = 300, -- speed up scrolling a bit by disabling syntax highlighting on very long lines
  tabstop = 4, -- insert 4 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  termsync = false, -- fast scrolling is causing tearing on Ghostty
  undofile = true, -- enable persistent undo
  wrap = false, -- display lines as one long line
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append("c")

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
