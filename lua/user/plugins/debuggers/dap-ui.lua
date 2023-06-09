return {
  "rcarriga/nvim-dap-ui",
  version = "^3.8.0",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-dap-virtual-text",
    "persistent-breakpoints.nvim",
    { import = "user.plugins.debuggers.adapters" },
  },
  keys = {
    --stylua: ignore
    { "<leader>db", function() require("dapui").toggle() end, desc = "Debugger" },
  },
  opts = {
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7"),
    layouts = {
      {
        -- You can change the order of elements in the sidebar
        -- Provide as ID strings or tables with "id" and "size" keys
        elements = {
          {
            id = "scopes",
            size = 0.25, -- Can be float or integer > 1
          },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        size = 40,
        position = "left", -- Can be "left", "right", "top", "bottom"
      },
      {
        elements = {
          "repl",
        },
        size = 10,
        position = "bottom",
      },
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "single", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil, -- Can be integer or nil.
    },
  },
  config = function (_, opts)
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup(opts)

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end
}
