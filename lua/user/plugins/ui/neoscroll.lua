return {
  "karb94/neoscroll.nvim",
  keys = {
    -- stylua: ignore
    "zt", "zz", "zb", "<PageUp>", "<PageDown>",
  },
  config = function()
    require("neoscroll").setup({
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = { "zt", "zz", "zb" },
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil, -- Default easing function
      pre_hook = nil, -- Function to run before the scrolling animation starts
      post_hook = nil, -- Function to run after the scrolling animation ends
      performance_mode = true, -- Disable "Performance Mode" on all buffers.
    })

    local t = {}
    -- Syntax: t[keys] = {function, {function arguments}}
    t["<PageUp>"] = { "scroll", { "-vim.wo.scroll", "true", "350" } }
    t["<PageDown>"] = { "scroll", { "vim.wo.scroll", "true", "350" } }
    t["zt"] = { "zt", { "250" } }
    t["zz"] = { "zz", { "250" } }
    t["zb"] = { "zb", { "250" } }

    require("neoscroll.config").set_mappings(t)
  end,
}
