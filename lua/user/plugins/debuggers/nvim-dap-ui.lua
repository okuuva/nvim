---@type LazyPluginSpec
return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "nvim-dap-virtual-text",
    "persistent-breakpoints.nvim",
    { import = "user.plugins.debuggers.adapters" },
  },
  --stylua: ignore
  keys = {
    { "<leader>DD", function() require("dapui").toggle() end, desc = "Debugger UI" },
    { "<leader>DT", function() require("persistent-breakpoints.api").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>Dt", function() require("persistent-breakpoints.api").set_conditional_breakpoint() end, desc = "Conditional Breakpoint" },
    { "<leader>Dc", function() require("persistent-breakpoints.api").clear_all_breakpoints() end, desc = "Clear All Breakpoints" },
    { "<leader>DL", function() require("persistent-breakpoints.api").set_log_point() end, desc = "Log Point" },
    { "<leader>DC", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>DO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>DI", function() require("dap").step_into() end, desc = "Step Into" },
  },
  init = function()
    require("user.util").wk_add({
      { "<leader>D", group = "Debugger" },
    })
    -- Define the icons for DAP-related signs (breakpoint, logpoint, etc.)
    vim.fn.sign_define("DapBreakpoint", {
      text = "●",
      texthl = "DiagnosticError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapBreakpointCondition", {
      text = "◆",
      texthl = "DiagnosticWarn",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapLogPoint", {
      text = "▶",
      texthl = "DiagnosticInfo",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapStopped", {
      text = "➜",
      texthl = "DiagnosticOk",
      linehl = "Visual",
      numhl = "",
    })
  end,
  opts = {
    floating = {
      border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    },
  },
  config = function(_, opts)
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
  end,
}
