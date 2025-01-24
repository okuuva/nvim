local render = function(props)
  local helpers = require("incline.helpers")
  local devicons = require("nvim-web-devicons")
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
  if filename == "" then
    filename = "[No Name]"
  end
  local ft_icon, ft_color = devicons.get_icon_color(filename)
  local modified = vim.bo[props.buf].modified
  return {
    ft_icon and { "", guifg = ft_color } or "",
    ft_icon and { ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
    " ",
    { filename, gui = modified and "bold,italic" or "bold" },
    " ",
  }
end

return {
  "b0o/incline.nvim",
  -- "okuuva/incline.nvim",
  -- branch = "allow-dynamic-margins",
  opts = {
    highlight = {
      groups = {
        InclineNormal = {
          default = true,
          group = "Normal",
        },
        InclineNormalNC = {
          default = true,
          group = "NormalNC",
        },
      },
    },
    window = {
      padding = 0,
      margin = {
        horizontal = 0,
        -- FIXME: it ain't workin
        -- doesn't render at all
        --
        -- vertical = function()
        --   local current_line, _ = unpack(vim.api.nvim_win_get_cursor(0))
        --   local margin = 1
        --   if current_line == 1 then
        --     margin = 2
        --   end
        --   return { top = margin, bottom = margin }
        -- end,
      },
    },
    render = render,
  },
  event = "VeryLazy",
}
