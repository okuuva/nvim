---@type LazyPluginSpec
return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  ft = { 'rust' },
  dependencies = { 'mrjones2014/codesettings.nvim' },
  init = function()
    vim.g.rustaceanvim = {
      -- I want VS Code settings to override my settings,
      -- not the other way around, so use codesettings.nvim
      -- instead of rustaceanvim's built-in vscode settings loader
      load_vscode_settings = false,
      -- the global hook doesn't work when configuring rust-analyzer with rustaceanvim
      settings = function(_, config)
        return require('codesettings').with_local_settings('rust-analyzer', config)
      end,
      default_settings = {
        ['rust-analyzer'] = {
          -- your global LSP settings go here
        },
      },
    }
  end,
}
