local api = vim.api

-- windows to close with "q"
local file_type_group = api.nvim_create_augroup("_file_type", {})

api.nvim_create_autocmd("FileType", {
  group = file_type_group,
  pattern = { "help", "startuptime", "qf", "lspinfo" },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})

api.nvim_create_autocmd("FileType", {
  group = file_type_group,
  pattern = "man",
  command = [[nnoremap <buffer><silent> q :bdelete<CR>]],
})

-- no point creating these if running a version that doesn't support
-- the necessary functionality
if vim.fn.has("nvim-0.11") == 1 then
  -- use builtin lsp.foldexpr if if nvim-ufo (https://github.com/kevinhwang91/nvim-ufo)
  -- isn't in use, and if both client and server support it
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if
        package.loaded.ufo
        or not client
        or not client.supports_method("textDocument/foldingRange")
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
end

local persisted_hooks = api.nvim_create_augroup("PersistedHooks", {})

api.nvim_create_autocmd("User", {
  group = persisted_hooks,
  pattern = { "PersistedLoadPost", "PersistedTelescopeLoadPost" },
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
