local M = {}

local servers = {
  "fuzzy_ruby_ls",
  "jsonls",
  "lua_ls",
  "nixd",
  "nushell",
}

for _, server_name in ipairs(servers) do
  local custom_opts_exist, opts = pcall(require, "user.plugins.lsp.servers." .. server_name)
  if not custom_opts_exist then
    opts = {}
  end

  M[server_name] = opts or {}
end

return M
