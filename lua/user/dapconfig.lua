local status_ok, dap_python = pcall(require, "dap-python")
if status_ok then
  dap_python.setup(vim.g.python3_host_prog)
end
