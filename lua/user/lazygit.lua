local settings = {
  lazygit_floating_window_winblend = 0, -- transparency of floating window
  lazygit_floating_window_scaling_factor = 1, -- scaling factor for floating window
  lazygit_floating_window_corner_chars = {'╭', '╮', '╰', '╯'}, -- customize lazygit popup window corner characters
  lazygit_floating_window_use_plenary = 0, -- use plenary.nvim to manage floating window if available
  lazygit_use_neovim_remote = 1, -- fallback to 0 if neovim-remote is not installed
}

for k, v in pairs(settings) do
  vim.g[k] = v
end
