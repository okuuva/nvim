local settings = {
  registers_tab_symbol = "·",
  registers_space_symbol = " ",
  registers_return_symbol = "⏎",
  registers_delay = 0,
  registers_register_key_sleep = 0,
  registers_show_empty_registers = 1,
  registers_trim_whitespace = 1,
  registers_hide_only_whitespace = 0,
  registers_window_border = "none",
  registers_window_min_height = 3,
  registers_window_max_width = 100,
  registers_show = '*+"-/_=#%.0123456789abcdefghijklmnopqrstuvwxyz:',
  registers_paste_in_normal_mode = 1,
  system_clip = 0,
}

for k, v in pairs(settings) do
  vim.g[k] = v
end

