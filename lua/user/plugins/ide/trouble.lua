---@type LazyPluginSpec
return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  keys = {
    { "<leader>dd", "<cmd>Trouble diagnostics filter.buf=0<CR>", desc = "Document diagnostics" },
    { "<leader>dD", "<cmd>Trouble diagnostics<CR>", desc = "Workspace diagnostics" },
    { "<leader>dl", "<cmd>Trouble lsp<CR>", desc = "LSP" },
    { "<leader>dL", "<cmd>Trouble loclist<CR>", desc = "Location list" },
    { "<leader>ds", "<cmd>Trouble symbols toggle<CR>", desc = "Symbols list" },
    { "<leader>dq", "<cmd>Trouble qflist<CR>", desc = "Quickfix" },
    -- dTs the todo list, defined in todo-comments.lua
    -- lsp
    { "gd", "<cmd>Trouble lsp_definitions<cr>", desc = "Goto Definition" },
    { "grr", "<cmd>Trouble lsp_references<cr>", desc = "Goto References" },
    { "gri", "<cmd>Trouble lsp_implementations<cr>", desc = "Goto Implementation" },
  },
  ---@module "trouble"
  ---@type trouble.Config
  opts = {
    focus = true,
    preview = {
      border = "none",
    },
    modes = {
      symbols = {
        win = {
          size = 60,
        },
      },
    },
  },
}
