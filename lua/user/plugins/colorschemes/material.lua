---@type LazyPluginSpec
return {
  "marko-cerovac/material.nvim",
  opts = {
    contrast = {
      terminal = false, -- Enable contrast for the built-in terminal
      sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
      floating_windows = false, -- Enable contrast for floating windows
      cursor_line = true, -- Enable darker background for the cursor line
      non_current_windows = false, -- Enable darker background for non-current windows
      filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
    },

    styles = { -- Give comments style such as bold, italic, underline etc.
      comments = {
        italic = true,
      },

      strings = {},
      keywords = {
        bold = true,
        italic = true,
      },
      functions = {},
      variables = {},
      operators = {},
      types = {},
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
      -- Available plugins:
      "blink",
      -- "coc",
      -- "colorful-winsep",
      "dap",
      -- "dashboard",
      -- "eyeliner",
      -- "fidget",
      "flash",
      "gitsigns",
      "harpoon",
      -- "hop",
      "illuminate",
      -- "indent-blankline",
      -- "lspsaga",
      -- "mini",
      -- "neogit",
      -- "neo-tree",
      -- "neorg",
      "neotest",
      "noice",
      -- "nvim-cmp",
      -- "nvim-navic",
      -- "nvim-notify",
      -- "nvim-tree",
      "nvim-web-devicons",
      -- "rainbow-delimiters",
      -- "sneak",
      "telescope",
      "trouble",
      "which-key",
    },

    disable = {
      colored_cursor = true, -- Disable the colored cursor
      borders = true, -- Disable borders between verticaly split windows
      background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
      term_colors = false, -- Prevent the theme from setting terminal colors
      eob_lines = false, -- Hide the end-of-buffer lines
    },

    high_visibility = {
      lighter = false, -- Enable higher contrast text for lighter style
      darker = true, -- Enable higher contrast text for darker style
    },

    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    -- Custom colors must be a function that takes in the default colors table as
    -- a paramter, and then modifies them.
    -- To see the available colors, see lua/material/colors/init.lua
    custom_colors = function(colors)
      colors.git.added = "#5E9926"
      colors.git.removed = "#bf6069"
    end,

    -- Overwrite highlights with your own
    custom_highlights = function(colors)
      return {
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
        --   strikethrough = false, -- make group striked trough
        --   reverse = false, -- reverse the fg and bg colors
        --   link = "SomeOtherGroup", -- link to some other highlight group
        -- },
        -- VertSplit = { bg = colors.editor.bg_alt },
        -- WinSeparator = { link = "VertSplit" },
        BlinkCmpLabelDeprecated = { strikethrough = true },
        Folded = { fg = colors.editor.disabled, bg = colors.editor.bg, italic = true },
        TelescopeMatching = { link = "Search" },
        -- Snacks indent, replicate indent-blankline behavior
        SnacksIndent = { fg = colors.editor.border },
        SnacksIndentScope = { fg = colors.editor.disabled },
        SnacksIndentChunk = { fg = colors.editor.disabled },

        SnacksBackdrop = { bg = colors.editor.bg_alt },
      }
    end,
  },
}
