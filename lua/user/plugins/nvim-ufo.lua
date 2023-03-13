local fold_peek = function()
  local winid = ufo.peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end

-- Customise fold text
local fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  init = function()
    vim.o.foldcolumn = "1" -- '1' is best when using statuscol.nvim
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.foldmethod = "manual" -- set back to manual so that ufo works
    vim.o.foldexpr = "0" -- this shouldn't matter since foldmethod is now manual instead of expr but doesn't hurt either
  end,
  config = function()
    ufo = require("ufo")

    vim.keymap.set("n", "zR", ufo.openAllFolds)
    vim.keymap.set("n", "zM", ufo.closeAllFolds)
    vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
    vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    vim.keymap.set("n", "K", fold_peek)

    -- global handler
    ufo.setup({
      fold_virt_text_handler = fold_virt_text_handler,
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
      end,
    })

    -- buffer scope handler
    -- will override global handler if it is existed
    local bufnr = vim.api.nvim_get_current_buf()
    ufo.setFoldVirtTextHandler(bufnr, fold_virt_text_handler)
  end,
}
