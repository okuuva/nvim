---@type LazyPluginSpec
return {
  "olimorris/codecompanion.nvim",
  cond = require("user.util").ai_helpers_allowed(),
  version = "v15.*",
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" }, -- see https://github.com/olimorris/codecompanion.nvim/issues/377
    "nvim-treesitter/nvim-treesitter",
    "zbirenbaum/copilot.lua",
    "ravitemer/mcphub.nvim",
    {
      "HakonHarnes/img-clip.nvim",
      optional = true,
      opts = {
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
          },
        },
      },
    },
  },
  opts = {
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
  },
}
