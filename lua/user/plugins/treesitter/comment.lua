return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  init = function()
    -- from JoosepAlviste/nvim-ts-context-commentstring readme:
    -- Set vim.g.skip_ts_context_commentstring_module = true somewhere in your configuration to skip backwards
    -- compatibility routines and speed up loading.
    -- see https://github.com/JoosepAlviste/nvim-ts-context-commentstring/blob/bdd2a3293340465a516b126d10894f6d5cb5213c/README.md?plain=1#L40
    vim.g.skip_ts_context_commentstring_module = true
  end,
  opts = function()
    local commentstring = require("ts_context_commentstring.integrations.comment_nvim")
    return {
      ---Add a space b/w comment and the line
      padding = true,
      ---Whether the cursor should stay at its position
      sticky = true,
      ---Lines to be ignored while (un)comment
      ignore = nil,
      ---LHS of toggle mappings in NORMAL mode
      toggler = {
        ---Line-comment toggle keymap
        line = "gcc",
        ---Block-comment toggle keymap
        block = "gbc",
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap
        line = "gc",
        ---Block-comment keymap
        block = "gb",
      },
      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        above = "gcO",
        ---Add comment on the line below
        below = "gco",
        ---Add comment at the end of line
        eol = "gcA",
      },
      ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },
      ---Function to call before (un)comment
      pre_hook = commentstring.create_pre_hook(),
      ---Function to call after (un)comment
      post_hook = nil,
    }
  end,
}
