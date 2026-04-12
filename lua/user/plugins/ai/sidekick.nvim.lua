---@type LazyPluginSpec
return {
  "folke/sidekick.nvim",
  cond = require("user.util").ai_helpers_allowed("folke/sidekick.nvim"),
  -- stylua: ignore
  keys = {
    { "<leader>aa", function() require("sidekick.cli").toggle("claude") end, desc = "Sidekick Toggle CLI" },
    { "<leader>as", function() require("sidekick.cli").select({ filter = { installed = true } }) end, desc = "Select CLI" },
    { "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, mode = { "x", "n" }, desc = "Send This" },
    { "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = { "x" }, desc = "Send Visual Selection" },
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
  config = function(_, opts)
    require("sidekick").setup(opts)
    if vim.fn.executable("cmux") == 1 then
      require("user.sidekick.cmux").register()
    end
  end,
  opts = {
    nes = {
      enabled = false,
    },
    cli = {
      mux = {
        backend = "cmux",
        enabled = vim.env.CMUX_SURFACE_ID ~= nil,
        create = "window",
      },
      tools = {
        auggie = {
          cmd = { "auggie", "--workspace-root", "." },
          url = "https://docs.augmentcode.com/cli/setup-auggie/install-auggie-cli",
        },
        claude = {
          cmd = { "claude", "--dangerously-skip-permissions" },
        },
      },
      win = {
        keys = {
          prompt = { "<c-.>", "prompt", mode = "t", desc = "insert prompt or context" },
        },
        layout = "bottom",
        split = {
          width = 100,
          height = 30,
        },
      },
    },
  },
}
