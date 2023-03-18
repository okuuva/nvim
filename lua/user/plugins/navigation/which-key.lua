local setup_opts = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "shadow", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local register_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Dashboard" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["C"] = { "<cmd>close<CR>", "Close split" },
  ["L"] = { "<cmd>Lazy<cr>", "Lazy" },
  ["m"] = { "<cmd>Mason<cr>", "Mason" },
  ["q"] = { "<cmd>qa!<CR>", "Quit" },
  ["w"] = { "<cmd>w<cr>", "Write" },

  b = { name = "Buffers" },

  d = {
    name = "Diagnostics",
    d = { "<cmd>Trouble document_diagnostics<CR>", "Document diagnostics" },
    D = { "<cmd>Trouble workspace_diagnostics<CR>", "Workspace diagnostics" },
    j = { vim.diagnostic.goto_next, "Next Diagnostic" },
    k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
    l = { vim.diagnostic.open_float, "Line diagnostics" },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    t = { "<cmd>TodoTrouble<cr>", "TODO-list" },
    T = { "<cmd>TroubleToggle<CR>", "Toggle window" },
    v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle virtual line diagnostics" },
  },

  g = {
    name = "Git",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit (for current file)" },
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    f = { "<cmd>LazyGitFilterCurrentFile<CR>", "Show file commits" },
    l = { "<cmd>lua require 'gitsigns'.blame_line({full = true, ignore_whitespace = true})<cr>", "Blame" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    P = { "<cmd>LazyGitFilter<CR>", "Show project commits" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    t = {
      name = "Toggle",
      b = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Current line blame" },
      d = { "<cmd>lua require 'gitsigns'.toggle_deleted()<cr>", "Deleted lines" },
      w = { "<cmd>lua require 'gitsigns'.toggle_word_diff()<cr>", "Word diff" },
      l = { "<cmd>lua require 'gitsigns'.toggle_linehl()<cr>", "Line highlight" },
      n = { "<cmd>lua require 'gitsigns'.toggle_numhl()<cr>", "Number highlight" },
      s = { "<cmd>lua require 'gitsigns'.toggle_signs()<cr>", "Sign column" },
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Trouble lsp_definitions<CR>", "Definition" },
    f = { "<cmd>lua _LSP_FORMAT()<cr>", "Format" },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>lua Msg(vim.lsp.get_active_clients())<cr>", "Inspect" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    L = { "<cmd>Trouble loclist<CR>", "Location list" },
    o = { "<cmd>LspLog<cr>", "Log" },
    q = { "<cmd>Trouble quickfix<CR>", "Quickfix" },
    r = { "<cmd>Trouble lsp_references<CR>", "References" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Search Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Search Workspace Symbols" },
    t = { "<cmd>Trouble lsp_type_definitions<CR>", "Type definitions list" },
  },

  n = { name = "Neoconf" },

  p = { name = "Pastebin" },

  s = { name = "Search" },

  S = {
    name = "Split",
    h = { "<cmd>split<cr>", "Horizontal split" },
    S = { "<cmd>vsplit<cr>", "Vertical split" },
  },

  t = { name = "TreeSitter" },
}

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup(setup_opts)
    require("which-key").register(mappings, register_opts)
  end,
}
