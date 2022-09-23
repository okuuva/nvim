local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

which_key.setup({
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
})

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local picker_enabled, picker = pcall(require, "window-picker")

local pick_window = function()
  local picked_window_id = picker_enabled and picker.pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Dashboard" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["C"] = { "<cmd>close<CR>", "Close split" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "File explorer" },
  ["m"] = { "<cmd>Mason<cr>", "Mason" },
  ["q"] = { "<cmd>qa!<CR>", "Quit" },
  ["r"] = { '<cmd>lua require("renamer").rename()<cr>', "Rename" },
  ["w"] = { pick_window, "Pick a window" },
  b = {
    name = "Buffers",
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    f = { "<cmd>Telescope buffers<cr>", "Find" },
    e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
    l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
    D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
    L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
  },

  d = {
    name = "Diagnostics",
    d = { "<cmd>Trouble document_diagnostics<CR>", "Document diagnostics" },
    D = { "<cmd>Trouble workspace_diagnostics<CR>", "Workspace diagnostics" },
    j = { vim.diagnostic.goto_next, "Next Diagnostic" },
    k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
    l = { vim.diagnostic.open_float, "Line diagnostics" },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    t = { "<cmd>TroubleToggle<CR>", "Toggle window" },
    v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle virtual line diagnostics" },
  },

  g = {
    name = "Git",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit (for current file)" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    g = { "<cmd>LazyGit<CR>", "Lazygit" },
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
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    D = { "<cmd>Trouble lsp_definitions<CR>", "Definitions list" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    L = { "<cmd>Trouble loclist<CR>", "Location list" },
    q = { "<cmd>Trouble quickfix<CR>", "Quickfix" },
    r = { "<cmd>Trouble lsp_references<CR>", "References" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Search Document Symbols" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Search Workspace Symbols" },
    t = { "<cmd>Trouble lsp_type_definitions<CR>", "Type definitions list" },
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    C = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Search Current Word" },
    f = {
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false, hidden = true, no_ignore = true})<cr>",
      "Files",
    },
    h = { "<cmd>Telescope help_tags theme=ivy<cr>", "Help" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    p = { "<cmd>Telescope projects<cr>", "Projects" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    R = { "<cmd>lua require('spectre').open()<CR>", "Search and Replace" },
    s = { "<cmd>Telescope luasnip<cr>", "Snippets" },
    S = { "<cmd>Telescope session-lens search_session<cr>", "Sessions" },
    t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Text" },
  },

  t = {
    name = "TreeSitter",
    c = { "<cmd>TSContextToggle<cr>", "Toggle context" },
    p = { "<cmd>TSPlaygroundToggle<cr>", "Toggle Playground" },
    t = { "<cmd>Twilight<CR>", "Toggle Twilight" },
  },
}

which_key.register(mappings, opts)
