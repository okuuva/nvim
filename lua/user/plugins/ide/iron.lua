return {
  "hkupty/iron.nvim",
  keys = {
    { "<leader>RA", "<cmd>IronAttach<cr>", desc = "Attach" },
    { "<leader>RS", "<cmd>IronRepl<cr>", desc = "Start" },
    { "<leader>RR", "<cmd>IronRestart<cr>", desc = "Restart" },
    { "<leader>RF", "<cmd>IronFocus<cr>", desc = "Focus" },
    { "<leader>RH", "<cmd>IronHide<cr>", desc = "Hide" },
  },
  opts = function()
    return {
      config = {
        -- Highlights the last sent block with bold
        highlight_last = "IronLastSent",

        -- Toggling behavior is on by default.
        -- Other options are: `single` and `focus`
        visibility = require("iron.visibility").toggle,

        -- Scope of the repl
        -- By default it is one for the same `pwd`
        -- Other options are `tab_based` and `singleton`
        scope = require("iron.scope").path_based,

        -- Whether the repl buffer is a "throwaway" buffer or not
        scratch_repl = true,

        -- Automatically closes the repl window on process end
        close_window_on_exit = true,
        repl_definition = {
          -- forcing a default
          python = require("iron.fts.python").ptipython,
        },
        -- Repl position. Check `iron.view` for more options,
        -- currently there are four positions: left, right, bottom, top,
        -- the param is the width/height of the float window
        repl_open_cmd = require("iron.view").split.vertical.botright("40%"),
        -- If the repl buffer is listed
        buflisted = false,
      },

      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
    }
  end,
  config = function(_, opts)
    require("iron.core").setup(opts)
  end,
}
