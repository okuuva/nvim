---@type LazyPluginSpec
return {
  "ethanholz/nvim-lastplace",
  event = "BufReadPre",
  opts = {
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = require("user.util").vcs_filetypes,
    lastplace_open_folds = false,
  },
}
