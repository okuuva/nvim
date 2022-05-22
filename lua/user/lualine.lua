local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "hint" },
  symbols = { error = " ", warn = " ", hint = " " },
  update_in_insert = true,
  always_visible = false,
}

local diff = {
  "diff",
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function(str)
    return "-- " .. str .. " --"
  end,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local clock = function()
  return os.date("%H:%M", os.time())
end

-- Trigger rerender of status line every minute for clock
if _G.Statusline_timer == nil then
  _G.Statusline_timer = vim.loop.new_timer()
else
  _G.Statusline_timer:stop()
end
_G.Statusline_timer:start(
  0,
  60000,
  vim.schedule_wrap(function()
    vim.api.nvim_command("redrawstatus")
  end)
)

-- Custom toggleterm extension
local toggleterm = {
  filetypes = { "toggleterm" },
  sections = {
    lualine_a = { mode },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { clock },
  },
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "Outline", "gitcommit" },
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diff, diagnostics },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "location" },
    lualine_z = { clock },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = { clock },
  },
  tabline = {},
  extensions = { "nvim-tree", toggleterm },
})
