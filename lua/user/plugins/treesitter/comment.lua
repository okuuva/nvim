return {
  "numToStr/Comment.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local commentstring = require("ts_context_commentstring.integrations.comment_nvim")
    require("Comment").setup({
      pre_hook = commentstring.create_pre_hook(),
    })
  end,
}
