---@type LazyPluginSpec
return {
  "folke/sidekick.nvim",
  cond = require("user.util").ai_helpers_allowed("folke/sidekick.nvim"),
  -- stylua: ignore
  keys = {
    { "<leader>aa", function() require("sidekick.cli").toggle() end, desc = "Sidekick Toggle CLI" },
    -- Or to select only installed tools: require("sidekick.cli").select({ filter = { installed = true } })
    { "<leader>as", function() require("sidekick.cli").select() end, desc = "Select CLI" },
    { "<leader>at",
      function() require("sidekick.cli").send({ msg = "{this}" }) end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>av",
      function() require("sidekick.cli").send({ msg = "{selection}" }) end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
  },
  init = function()
    require("user.util").wk_add({
      { "<leader>a", group = "AI" },
    })
  end,
  opts = {
    nes = {
      enabled = true,
    },
    cli = {
      mux = {
        backend = "tmux",
        enabled = false,
      },
      tools = {
        augie = {
          cmd = { "auggie", "--workspace-root", "." },
          url = "https://docs.augmentcode.com/cli/setup-auggie/install-auggie-cli",
        },
      },
      win = {
        split = {
          width = 100,
          height = 20,
        },
      },
    },
  },
}
