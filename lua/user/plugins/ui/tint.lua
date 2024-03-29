local ignored_buftypes = {
  terminal = true,
  notify = true,
}

return {
  "levouh/tint.nvim",
  event = "VeryLazy",
  config = function()
    local opts = {
      tint = -5, -- Darken colors, use a positive value to brighten
      saturation = 0.6, -- Saturation to preserve
      transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
      tint_background_colors = true, -- Tint background portions of highlight groups
      highlight_ignore_patterns = {}, -- Highlight group patterns to ignore, see `string.find`
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.bo[bufid].buftype
        local diff = vim.wo[winid].diff
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

        -- Do not tint ignored buffer types, floating and diff windows, tint everything else
        return ignored_buftypes[buftype] ~= nil or floating or diff
      end,
    }
    require("tint").setup(opts)
  end,
}
