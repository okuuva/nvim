vim.lsp.config("*", {
  before_init = function(_, config)
    local ok, codesettings = pcall(require, "codesettings")
    if not ok then
      return
    end
    config = codesettings.with_local_settings(config.name, config)
  end,
})

---@type LazyPluginSpec
return {
  "mrjones2014/codesettings.nvim",
  ft = { "json", "jsonc", "lua" },
  event = "BufReadPre",
  opts = {
    ---Enable live reloading of settings when config files change; for servers that support it,
    ---this is done via the `workspace/didChangeConfiguration` notification, otherwise the
    ---server is restarted
    live_reload = true,
  },
}
