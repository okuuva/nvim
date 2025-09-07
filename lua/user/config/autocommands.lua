local api = vim.api

-- windows to close with "q"
local quick_close_filetypes = api.nvim_create_augroup("_quick_close_file_type", {})

api.nvim_create_autocmd("FileType", {
  group = quick_close_filetypes,
  pattern = { "help", "startuptime", "qf", "lspinfo" },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})

api.nvim_create_autocmd("FileType", {
  group = quick_close_filetypes,
  pattern = "man",
  command = [[nnoremap <buffer><silent> q :bdelete<CR>]],
})

local misc_filetype_autocommands = api.nvim_create_augroup("_misc_file_type", {})

-- set formatoptions
api.nvim_create_autocmd("FileType", {
  group = misc_filetype_autocommands,
  callback = function(_)
    -- Default is supposed to be "tcqj", something (maybe LSP or builtin FileType autocommands) sets some other settings
    -- depending on the file type

    -- Auto-wrap text using 'textwidth'
    -- vim.opt.formatoptions:remove("t") -- this misbehaves

    -- Auto-wrap comments using 'textwidth', inserting the current comment leader automatically.
    vim.opt.formatoptions:append("c")

    -- Automatically insert the current comment leader after hitting <Enter> in Insert mode.
    vim.opt.formatoptions:append("r")

    -- Automatically insert the current comment leader after hitting 'o' or
    -- 'O' in Normal mode. In case comment is unwanted in a specific place
    -- use CTRL-U to quickly delete it.
    vim.opt.formatoptions:append("o")

    -- When 'o' is included: do not insert the comment leader for a //
    -- comment after a statement, only when // is at the start of the line.
    vim.opt.formatoptions:append("/")

    -- Allow formatting of comments with "gq".
    -- Note that formatting will not change blank lines or lines containing
    -- only the comment leader.  A new paragraph starts after such a line,
    -- or when the comment leader changes.
    vim.opt.formatoptions:append("q")

    -- Trailing white space indicates a paragraph continues in the next line.
    -- A line that ends in a non-white character ends a paragraph.
    -- vim.opt.formatoptions:append("w")

    -- Automatic formatting of paragraphs.  Every time text is inserted or
    -- deleted the paragraph will be reformatted.  See |auto-format|.
    -- When the 'c' flag is present this only happens for recognized
    -- comments.
    -- vim.opt.formatoptions:append("a")

    -- When formatting text, recognize numbered lists.  This actually uses
    -- the 'formatlistpat' option, thus any kind of list can be used.  The
    -- indent of the text after the number is used for the next line.  The
    -- default is to find a number, optionally followed by '.', ':', ')',
    -- ']' or '}'.  Note that 'autoindent' must be set too.  Doesn't work
    -- well together with "2".
    vim.opt.formatoptions:append("n")

    -- Vi-compatible auto-wrapping in insert mode: Only break a line at a
    -- blank that you have entered during the current insert command.  (Note:
    -- this is not 100% Vi compatible.  Vi has some "unexpected features" or
    -- bugs in this area.  It uses the screen column instead of the line
    -- column.)
    -- vim.opt.formatoptions:append("v")

    -- Long lines are not broken in insert mode: When a line was longer than
    -- 'textwidth' when the insert command started, Vim does not
    -- automatically format it.
    vim.opt.formatoptions:remove("l")

    -- Don't break a line after a one-letter word.  It's broken before it
    -- instead (if possible).
    vim.opt.formatoptions:append("1")

    -- Where it makes sense, remove a comment leader when joining lines.
    vim.opt.formatoptions:append("j")
  end,
})

-- use builtin lsp.foldexpr if if nvim-ufo (https://github.com/kevinhwang91/nvim-ufo) isn't in use, and if both client
-- and server support it
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if
      package.loaded.ufo
      or not client
      or not client:supports_method("textDocument/foldingRange")
      or not client.server_capabilities
      or not client.server_capabilities.foldingRangeProvider
    then
      return
    end
    vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
  end,
})

-- fall back to treesitter folding when LSP detaches unless using ufo
vim.api.nvim_create_autocmd("LspDetach", {
  callback = function(_)
    if package.loaded.ufo then
      return
    end
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})

local persisted_hooks = api.nvim_create_augroup("PersistedHooks", {})

api.nvim_create_autocmd("User", {
  group = persisted_hooks,
  pattern = { "PersistedLoadPost" },
  callback = function(session)
    local message = "Loaded session " .. vim.g.persisted_loaded_session

    vim.defer_fn(function()
      vim.notify(message, vim.log.levels.INFO, { title = "Session manager" })
    end, 0)
  end,
})

api.nvim_create_autocmd("BufWinEnter", {
  pattern = vim.fn.expand("~") .. "/zen",
  callback = function()
    vim.defer_fn(toggle_narrow_zen, 1) -- cursor misbehaves if this isn't delayed at least 1 ms
    require("wrapping").soft_wrap_mode()
    vim.api.nvim_command("startinsert")
  end,
})

local page_hooks = api.nvim_create_augroup("PageHooks", {})

api.nvim_create_autocmd("User", {
  group = page_hooks,
  pattern = { "PageOpen", "PageOpenFile" },
  callback = function()
    vim.opt.foldcolumn = "0"
    vim.opt.signcolumn = "no"
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.sidescrolloff = 0
    vim.opt.scrolloff = 0
    vim.opt.breakindent = false -- Disable break indent
    vim.opt.showbreak = "" -- Make sure no special symbols are shown at line break
  end,
})

local showbreak = "↪ " -- string to indicate visual linebreak

api.nvim_create_autocmd("WinEnter", {
  group = vim.api.nvim_create_augroup("SetShowbreakOnlyInActiveWindows", { clear = true }),
  callback = function()
    vim.opt_local.showbreak = showbreak
  end,
})

api.nvim_create_autocmd("WinLeave", {
  group = "SetShowbreakOnlyInActiveWindows",
  callback = function()
    vim.opt_local.showbreak = ""
  end,
})
