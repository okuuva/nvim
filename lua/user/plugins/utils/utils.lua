---@type table<LazyPluginSpec>
return {
  { import = "user.plugins.utils.markdown" },
  { import = "user.plugins.utils.mini" },
  { import = "user.plugins.utils.snacks" },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "b0o/schemastore.nvim", -- json schemas for jsonls
    lazy = true,
  },
  {
    "mcauley-penney/tidy.nvim",
    opts = {
      provide_undefined_editorconfig_behavior = true,
    },
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
    "echasnovski/mini.icons",
    lazy = true,
    version = "*",
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
  {
    "onsails/lspkind.nvim",
  },
  {
    "EtiamNullam/deferred-clipboard.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
