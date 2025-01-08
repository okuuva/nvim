return {
  -- revert back to official repo and tag once PR is merged:
  -- https://github.com/s1n7ax/nvim-window-picker/pull/91
  -- "s1n7ax/nvim-window-picker",
  -- version = "^2.0.0",
  "9ary/nvim-window-picker",
  branch = "big-letter-fixes",
  keys = {
    {
      "<leader>i",
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

    -- this can be axed once PR is merged:
    -- https://github.com/s1n7ax/nvim-window-picker/pull/90
    filter_func = function(windows, rules)
      local function predicate(wid)
        cfg = vim.api.nvim_win_get_config(wid)
        if not cfg.focusable then
          return false
        end
        return true
      end
      local filtered = vim.tbl_filter(predicate, windows)

      local dfilter = require("window-picker.filters.default-window-filter"):new()
      dfilter:set_config(rules)
      return dfilter:filter_windows(filtered)
    end,
  },
}
