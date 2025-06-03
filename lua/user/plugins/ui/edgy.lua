---@type LazyPluginSpec
return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  opts = {
    bottom = {
      -- lazyterm at the bottom with a height of 40% of the screen
      {
        ft = "lazyterm",
        title = "LazyTerm",
        size = { height = 0.4 },
        filter = function(buf)
          return not vim.b[buf].lazyterm_cmd
        end,
      },
      "Trouble",
      { ft = "qf", title = "QuickFix" },
      {
        ft = "help",
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
    },
    right = {
      {
        title = function()
          local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
          return vim.fn.fnamemodify(buf_name, ":t")
        end,
        ft = "Outline",
        pinned = true,
        open = "SymbolsOutlineOpen",
      },
    },
  },
}
