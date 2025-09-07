---@type LazyPluginSpec
return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  ---@module "edgy"
  ---@type Edgy.Config
  opts = {
    animate = {
      enabled = false,
    },
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
    },
    right = {
      {
        ft = "help",
        size = { width = 0.4 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
    },
  },
}
