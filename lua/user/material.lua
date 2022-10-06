vim.g.material_style = "darker"

local colors = require("material.colors")
local material = require("material")
material.setup({

  contrast = {
    sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
    floating_windows = false, -- Enable contrast for floating windows
    cursor_line = true, -- Enable darker background for the cursor line
    non_current_windows = true, -- Enable darker background for non-current windows
    popup_menu = false, -- Enable lighter background for the popup menu
  },

  italics = {
    comments = true, -- Enable italic comments
    keywords = false, -- Enable italic keywords
    functions = false, -- Enable italic functions
    strings = false, -- Enable italic strings
    variables = false, -- Enable italic variables
  },

  contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
    "terminal", -- Darker terminal background
    "packer", -- Darker packer background
    "qf", -- Darker qf list background
  },

  high_visibility = {
    lighter = false, -- Enable higher contrast text for lighter style
    darker = true, -- Enable higher contrast text for darker style
  },

  disable = {
    colored_cursor = false, -- Disable the colored cursor
    borders = true, -- Disable borders between verticaly split windows
    background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
    term_colors = false, -- Prevent the theme from setting terminal colors
    eob_lines = false, -- Hide the end-of-buffer lines
  },

  lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

  async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

  -- Overwrite highlights with your own
  custom_highlights = {
    -- YourHighlightGroup = {
    --   fg = "#SOME_COLOR", -- foreground color
    --   bg = "#SOME_COLOR", -- background color
    --   sp = "#SOME_COLOR", -- special color (for colored underlines, undercurls...)
    --   bold = false, -- make group bold
    --   italic = false, -- make group italic
    --   underline = false, -- make group underlined
    --   undercurl = false, -- make group undercurled
    --   underdot = false, -- make group underdotted
    --   underdash = false, -- make group underdotted
    --   striketrough = false, -- make group striked trough
    --   reverse = false, -- reverse the fg and bg colors
    --   link = "SomeOtherGroup", -- link to some other highlight group
    -- },
    VertSplit = { link = "NormalNC" },
    TSField = { fg = colors.fg },  -- this was set to { fg = colors.text } in upstream which makes sense but I didn't like the look of it
    NvimTreeSignColumn = { link = "SignColumn" },
    NvimTreeRootFolder = { fg = colors.accent },
    TroubleText = { fg = colors.text, bg = colors.none },
    TroubleCount = { fg = colors.purple, bg = colors.none },
    TroubleNormal = { fg = colors.fg, bg = colors.none },
    TroubleSignError = { fg = colors.error, bg = colors.none },
    TroubleSignWarning = { fg = colors.yellow, bg = colors.none },
    TroubleSignInformation = { fg = colors.paleblue, bg = colors.none },
    TroubleSignHint = { fg = colors.purple, bg = colors.none },
    TroubleFoldIcon = { fg = colors.accent, bg = colors.none },
    TroubleIndent = { fg = colors.border, bg = colors.none },
    TroubleLocation = { fg = colors.disabled, bg = colors.none },
  },
})
