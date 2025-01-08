return {
  "folke/snacks.nvim",
  version = "^2.0.0",
  priority = 1000,
  lazy = false,
  dependencies = {
    "mini.icons",
    "nvim-web-devicons",
  },
  -- stylua: ignore
  keys = {
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
  },
  ---@type snacks.Config
  opts = {
    ---@class snacks.lazygit.Config: snacks.terminal.Opts
    lazygit = {
      -- automatically configure lazygit to use the current colorscheme
      -- and integrate edit with the current neovim instance
      configure = true,
      -- extra configuration for lazygit that will be merged with the default
      -- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
      -- you need to double quote it: `"\"test\""`
      config = {
        os = {
          editPreset = "nvim-remote",
        },
      },
    },
    ---@type table<string, snacks.win.Config>
    styles = {
      lazygit = {
        height = 0,
        width = 0,
      },
    },
  },
}
