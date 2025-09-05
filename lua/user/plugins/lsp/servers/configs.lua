local M = {}

local legacy_servers = {
  "fuzzy_ruby_ls",
  "jsonls",
  "lua_ls",
  "nixd",
  "nushell",
  "yamlls",
}

local servers = {
  -- "tombi", -- in some ways better than taplo but a bit buggy, so continuing with taplo for now
}

for _, server_name in ipairs(legacy_servers) do
  local custom_opts_exist, opts = pcall(require, "user.plugins.lsp.servers." .. server_name)
  if not custom_opts_exist then
    opts = {}
  end

  M[server_name] = opts or {}
end

for _, server_name in ipairs(servers) do
  local custom_opts_exist, opts = pcall(require, "user.plugins.lsp.servers." .. server_name)
  if custom_opts_exist then
    vim.lsp.config(server_name, opts)
  end
  vim.lsp.enable(server_name)
end

return M
