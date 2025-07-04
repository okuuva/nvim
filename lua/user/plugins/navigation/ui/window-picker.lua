---@type LazyPluginSpec
return {
  "s1n7ax/nvim-window-picker",
  version = "^2.0.0",
  keys = {
    {
      "<leader>p",
      function()
        local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end,
      desc = "Pick a window",
    },
  },
  opts = {
    -- type of hints you want to get
    -- following types are supported
    -- 'statusline-winbar' | 'floating-big-letter'
    -- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar' will be
    -- 'floating-big-letter' draw big letter on a floating window
    -- used
    hint = "floating-big-letter",

    -- when you go to window selection mode, status bar will show one of
    -- following letters on them so you can use that letter to select the window
    selection_chars = "HTNSUEOA",

    show_prompt = false,

    filter_rules = {
      bo = {
        buftype = {},
      },
    },
  },
}
