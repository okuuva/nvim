return {
  "luukvbaal/statuscol.nvim", -- nvim >= 0.9
  event = "BufEnter",
  config = function()
    local builtin = require("statuscol.builtin")
    local cfg = {
      -- Builtin line number string options for ScLn() segment
      thousands = false, -- or line number thousands separator string ("." / ",")
      relculright = true, -- whether to right-align the cursor line number with 'relativenumber' set
      -- Builtin 'statuscolumn' options
      setopt = true, -- whether to set the 'statuscolumn', providing builtin click actions
      ft_ignore = nil, -- lua table with filetypes for which 'statuscolumn' will be unset
      -- Default segments (fold -> sign -> line number + separator)
      segments = {
        {
          sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true },
        },
        {
          text = { builtin.lnumfunc },
          condition = { true, builtin.not_empty },
        },
        {
          sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
        },
        { text = { builtin.foldfunc, " " } },
      },
      clickhandlers = {
        Lnum = builtin.lnum_click,
        FoldClose = builtin.foldclose_click,
        FoldOpen = builtin.foldopen_click,
        FoldOther = builtin.foldother_click,
        DapBreakpointRejected = builtin.toggle_breakpoint,
        DapBreakpoint = builtin.toggle_breakpoint,
        DapBreakpointCondition = builtin.toggle_breakpoint,
        DiagnosticSignError = builtin.diagnostic_click,
        DiagnosticSignHint = builtin.diagnostic_click,
        DiagnosticSignInfo = builtin.diagnostic_click,
        DiagnosticSignWarn = builtin.diagnostic_click,
        GitSignsTopdelete = builtin.gitsigns_click,
        GitSignsUntracked = builtin.gitsigns_click,
        GitSignsAdd = builtin.gitsigns_click,
        GitSignsChangedelete = builtin.gitsigns_click,
        GitSignsDelete = builtin.gitsigns_click,
      },
    }
    require("statuscol").setup(cfg)
  end,
}
