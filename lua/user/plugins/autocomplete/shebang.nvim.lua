---@type LazyPluginSpec
return {
  "LunarLambda/shebang.nvim",
  cmd = { "Shebang" },
  ft = {
    "bash",
    "csh",
    "fish",
    "lua",
    "perl",
    "php",
    "python",
    "ruby",
    "tcsh",
    "zsh",
  },
  opts = {
    auto_insert = { "shell" },
  },
}
