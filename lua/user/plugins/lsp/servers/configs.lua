local M = {}

local servers = {
  "jsonls",
  "lua_ls",
}

for _, server_name in ipairs(servers) do
  local opts = require("user.plugins.lsp.servers." .. server_name)
  M[server_name] = opts
end

return M
