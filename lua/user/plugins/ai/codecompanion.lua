---@type LazyPluginSpec
return {
  "olimorris/codecompanion.nvim",
  cond = require("user.util").ai_helpers_allowed(),
  version = "v15.*",
  keys = {
    { "<leader>aa", ":CodeCompanionActions<cr>", desc = "Action Panel" },
    { "<leader>ac", ":CodeCompanionChat Toggle<cr>", desc = "Toggle Chat" },
    { "<leader>ao", ":CodeCompanionCmd<cr>", desc = "Generate :Command" },

    { "<leader>ac", ":<C-u>'<,'>CodeCompanionChat Add<cr>", desc = "Add selection to chat", mode = { "x" } },
    { "<leader>ad", ":<C-u>'<,'>CodeCompanion /lsp<cr>", desc = "Diagnose selection", mode = { "x" } },
    { "<leader>ae", ":<C-u>'<,'>CodeCompanion /explain<cr>", desc = "Explain selection", mode = { "x" } },
    { "<leader>af", ":<C-u>'<,'>CodeCompanion /fix<cr>", desc = "Fix selection", mode = { "x" } },
    { "<leader>ad", ":<C-u>'<,'>CodeCompanion /lsp<cr>", desc = "Diagnose selection", mode = { "x" } },
  },
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
  init = function(_)
    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
  opts = {
    display = {
      action_palette = {
        provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
        opts = {
          show_default_actions = true, -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        },
      },
      chat = {
        window = {
          layout = "horizontal", -- float|vertical|horizontal|buffer
          border = "rounded",
          height = 0.5,
          full_height = false,
        },
      },
    },
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
