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
  -- TODO: switch back to upstream once the jsonls fix is merged
  -- see https://github.com/mrjones2014/codesettings.nvim/pull/34
  dir = "~/gits/neovim/codesettings.nvim",
  cond = true,
  ft = { "json", "jsonc" },
  event = "BufReadPre",
  opts = {},
}
