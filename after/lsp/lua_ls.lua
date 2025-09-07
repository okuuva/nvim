---@type vim.lsp.Config
return {
  on_attach = function(client, bufnr)
    local ft = vim.bo[bufnr].filetype
    if ft == "rockspec" then
      vim.schedule(function()
        vim.lsp.buf_detach_client(bufnr, client.id)
      end)
      return
    end
  end,
  ---@module "codesettings"
  ---@type lsp.lua_ls
  settings = {
    -- see https://luals.github.io/wiki/settings/
    Lua = {
      completion = {
        autoRequire = false,
      },
      diagnostics = {
        disable = {
          "missing-fields",
        },
      },
      hint = {
        arrayIndex = "Disable",
        enable = true,
        setType = true,
      },
      runtime = {
        version = "LuaJIT",
      },
    },
  },
}
