return {
  "tadaa/vimade",
  -- default opts (you can partially set these or configure them however you like)
  event = "VeryLazy",
  opts = {
    -- Recipe can be any of 'default', 'minimalist', 'duo', and 'ripple'
    -- Set animate = true to enable animations on any recipe.
    -- See the docs for other config options.
    recipe = { "minimalist", { animate = true } },
    -- ncmode = 'buffers' will fade inactive buffers (so the same buffer in multiple windows look the samd)
    -- ncmode = 'windows' will fade inactive windows.
    -- ncmode = 'focus' will only fade after you activate the `:VimadeFocus` command.
    ncmode = "buffers",
    fadelevel = 0.6, -- any value between 0 and 1. 0 is hidden and 1 is opaque.
    tint = {
      bg = { rgb = { 0, 0, 0 }, intensity = 0.4 }, -- adds 20% black to background
      -- fg = {rgb={0,0,255}, intensity=0.3}, -- adds 30% blue to foreground
      -- fg = {rgb={120,120,120}, intensity=1}, -- all text will be gray
      -- sp = {rgb={255,0,0}, intensity=0.5}, -- adds 50% red to special characters
      -- you can also use functions for tint or any value part in the tint object
      -- to create window-specific configurations
      -- see the `Tinting` section of the README for more details.
    },
    -- Time in milliseconds before re-checking windows. This is only used when usecursorhold
    -- is set to false.
    checkinterval = 100,
    -- enables cursorhold event instead of using an async timer.  This may make Vimade
    -- feel more performant in some scenarios. See h:updatetime.
    usecursorhold = false,
    -- when nohlcheck is disabled the highlight tree will always be recomputed. You may
    -- want to disable this if you have a plugin that creates dynamic highlights in
    -- inactive windows. 99% of the time you shouldn't need to change this value.
    nohlcheck = true,
    blocklist = {
      buf_and_filetypes = {
        buf_opts = {
          buftype = {
            "help",
          },
          filetype = {
            "help",
            "man",
            "trouble",
          },
        },
      },
    },
  },
}
