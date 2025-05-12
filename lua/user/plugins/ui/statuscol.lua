return {
  "luukvbaal/statuscol.nvim",
  event = "BufEnter",
  cond = not USING_PAGE,
  opts = function()
    local builtin = require("statuscol.builtin")
    return {
      relculright = true, -- whether to right-align the cursor line number with 'relativenumber' set
      segments = {
        -- Diagnostics etc
        {
          sign = {
            text = { ".*" },
            maxwidth = 1,
          },
        },
        -- line number
        {
          text = { builtin.lnumfunc },
          condition = { true, builtin.not_empty },
        },
        -- gitsigns
        {
          sign = {
            namespace = { "gitsigns" },
            colwidth = 1,
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
