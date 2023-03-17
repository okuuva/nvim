return {
  "mfussenegger/nvim-dap-python",
  lazy = true,
  config = function ()
    require("dap-python").setup(vim.g.python3_host_prog)
  end
}
