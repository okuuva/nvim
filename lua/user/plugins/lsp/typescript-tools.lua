---@type LazyPluginSpec
return {
  "pmizio/typescript-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
    "lbrayner/vim-rzip",
  },
  opts = {
    settings = {
      expose_as_code_action = "all",
    },
  },
}
