local only_on_wide_enough_displays = function()
  -- only check the width if status line is drawn on multiple windows
  return vim.o.laststatus < 3 and vim.fn.winwidth(0) > 120 or true
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "hint" },
  symbols = { error = " ", warn = " ", hint = " " },
  update_in_insert = false,
  always_visible = false,
}

local diff = {
  "diff",
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = only_on_wide_enough_displays,
}

local encoding = {
  "encoding",
  cond = only_on_wide_enough_displays,
}

local fileformat = {
  "fileformat",
  cond = only_on_wide_enough_displays,
}

local filename = {
  "filename",
  file_status = true, -- Displays file status (readonly status, modified status)
  newfile_status = true, -- Display new file status (new file means no write after created)
  path = 1, -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path
  -- 3: Absolute path, with tilde as the home directory

  shorting_target = 40, -- Shortens path to leave 40 spaces in the window
  -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = "[+]", -- Text to show when the file is modified.
    readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
    unnamed = "[No Name]", -- Text to show for unnamed buffers.
    newfile = "[New]", -- Text to show for new created file before first writting
  },
}

local filetype = {
  "filetype",
  cond = only_on_wide_enough_displays,
}

local mode = {
  "mode",
  cond = only_on_wide_enough_displays,
}

local progress = {
  "progress",
  cond = only_on_wide_enough_displays,
}

local function pwd()
  return "  " .. vim.fs.basename(vim.fn.getcwd())
end

local function tabs()
  local tab_number = vim.api.nvim_tabpage_get_number(0)
  local tab_count = #vim.api.nvim_list_tabpages()
  if tab_count > 1 then
    return "Tab " .. tab_number .. " / " .. tab_count
  end
  return ""
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "noice.nvim" },
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { mode },
      lualine_b = { pwd, diff, diagnostics },
      lualine_c = { filename, tabs },
      lualine_x = {},
      lualine_y = { encoding, fileformat, filetype },
      lualine_z = { "location", progress },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename, tabs },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "location", progress },
    },
    extensions = {
      "fzf",
      "lazy",
      "man",
    },
  },
  config = function(_, opts)
    local showcmd = {
      require("noice").api.status.command.get,
      cond = require("noice").api.status.command.has,
    }
    opts.sections.lualine_x = { showcmd }
    require("lualine").setup(opts)
  end,
}
