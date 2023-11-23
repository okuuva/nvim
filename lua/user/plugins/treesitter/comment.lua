return {
  "numToStr/Comment.nvim",
  event = "BufEnter",
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
      pre_hook = commentstring.create_pre_hook(),
    }
  end,
}
