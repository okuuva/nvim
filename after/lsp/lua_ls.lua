---@type vim.lsp.Config
return {
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
