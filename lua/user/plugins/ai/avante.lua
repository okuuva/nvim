local close_shortcuts = {
  "q",
  "<Esc>",
  "<leader>c",
  "<leader>C",
}

---@type LazyPluginSpec
return {
  "yetone/avante.nvim",
  build = "make",
  event = "VeryLazy",
  cond = require("user.util").ai_helpers_allowed("yetone/avante.nvim"),
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = "copilot",
    mappings = {
      sidebar = {
        close = close_shortcuts,
        close_from_input = {
          normal = close_shortcuts,
        },
      },
    },
    windows = {
      -- percentage
      width = 50,
      spinner = {
        thinking = { "🤔", "💭" },
      },
    },
    input = {
      provider = "snacks",
    },
    selector = {
      provider = "snacks",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",
    "folke/snacks.nvim", -- for input provider snacks
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    "HakonHarnes/img-clip.nvim", -- support for image pasting
    "MeanderingProgrammer/render-markdown.nvim",
  },
}
