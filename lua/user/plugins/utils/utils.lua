local function BdeleteAndCloseTabIfNotLast()
  local bufdelete = require("bufdelete")
  bufdelete.bufdelete(0, true)

  local tabpages = vim.api.nvim_list_tabpages()
  -- close tab if it's not the last one
  if #tabpages > 1 then
    vim.cmd("tabclose")
  end
end

return {
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "b0o/schemastore.nvim", -- json schemas for jsonls
    lazy = true,
  },
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
      { "<leader>c", BdeleteAndCloseTabIfNotLast, desc = "Close Buffer" },
    },
  },
  {
    "mcauley-penney/tidy.nvim",
    config = true,
    event = "BufWritePre",
  },
  {
    "felipec/vim-sanegx",
    event = "VeryLazy",
  },
  {
    -- this is ostensibly unnecessary but decoupling cursorhold events from updatetime
    -- might still be a good idea.
    -- see https://github.com/antoinemadec/FixCursorHold.nvim/issues/13
    "antoinemadec/FixCursorHold.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
}
