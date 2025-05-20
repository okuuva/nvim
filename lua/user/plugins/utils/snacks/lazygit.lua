---@type LazyPluginSpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>gB", function() Snacks.gitbrowse() end,      desc = "Git Browse", mode = { "n", "x" } },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gg", function() Snacks.lazygit() end,        desc = "Lazygit" },
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
    styles = {
      lazygit = {
        height = 0,
        width = 0,
      },
    },
  },
}
