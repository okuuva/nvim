return {
  "nvim-neotest/neotest",
  -- version = "^4.1.3",
  -- stylua: ignore
  keys = {
    -- run
    { "<leader>td", function() require("neotest").run.run(vim.fn.expand('%:h')) end, desc = "Run in current dir" },
    { "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand('%')) end, desc = "Run current file" },
    { "<leader>tp", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run tests for the whole project" },
    -- toggle
    { "<leader>tto", function() require("neotest").output_panel.toggle() end, desc = "Output panel" },
    { "<leader>tts", function() require("neotest").summary.toggle() end, desc = "Summary" },
  },
  dependencies = {
    -- common dependencies
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- adapters
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-plenary",
  },
  init = function()
    -- see https://github.com/nvim-neotest/neotest-go/blob/f2580cad67ef0181403cf65858ab638ffd3ede9f/README.md?plain=1#L16-42
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)
  end,
  config = function()
    local neotest = require("neotest")
    neotest.setup({
      adapters = {
        require("neotest-go"),
        require("neotest-plenary"),
      },
      open = {
        open_on_run = false,
      },
      quickfix = {
        enabled = true,
        open = true,
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = true,
      },
    })
  end,
}
