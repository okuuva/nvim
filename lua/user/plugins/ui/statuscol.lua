return {
  "luukvbaal/statuscol.nvim", -- nvim >= 0.9
  -- branch = "0.10", -- go back to main after this gets merged: https://github.com/luukvbaal/statuscol.nvim/tree/0.10
  event = "BufEnter",
  opts = function()
    local builtin = require("statuscol.builtin")
    return {
      relculright = true, -- whether to right-align the cursor line number with 'relativenumber' set
      segments = {
        -- Diagnostics
        {
          sign = {
            namespace = { "Diagnostic.*" },
            auto = true,
          },
        },
        -- line number
        {
          text = { builtin.lnumfunc },
          condition = { true, builtin.not_empty },
        },
        -- gitsigns numhl
        {
          sign = {
            namespace = { "gitsigns" },
            colwidth = 1,
            maxwidth = 0, -- FIXME: this is needed in order to hide the signs but keep numhl
            auto = true,
          },
        },
        -- folds
        {
          text = { builtin.foldfunc, " " },
        },
      },
    }
  end,
}
