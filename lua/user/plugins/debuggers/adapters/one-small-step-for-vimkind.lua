---@type LazyPluginSpec
return {
  "jbyuki/one-small-step-for-vimkind", -- lua
  dependencies = { "nvim-dap" },
  lazy = true,
  -- stylua: ignore
  keys = {
    { "<leader>DN", function() require("osv").launch({port = 57319}) end, desc = "Launch Neovim debug server" },
  },
  config = function()
    local dap = require("dap")
    dap.configurations.lua = {
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
        port = 57319,
      },
    }

    dap.adapters.nlua = function(callback, config)
      callback({ type = "server", host = config.host, port = config.port })
    end
  end,
}
