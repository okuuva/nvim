return {
  "luukvbaal/statuscol.nvim", -- nvim >= 0.9
  event = "BufEnter",
  opts = function()
    local builtin = require("statuscol.builtin")
    return {
      relculright = true, -- whether to right-align the cursor line number with 'relativenumber' set
      segments = {
        -- Diagnostics
        {
          sign = {
            name = { "Diagnostic" },
            auto = true,
          },
        },
        -- line number
        {
          text = { builtin.lnumfunc },
          condition = { true, builtin.not_empty },
        },
        -- something to do with gitsigns numhl
        {
          sign = {
            name = { ".*" },
            colwidth = 1,
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
