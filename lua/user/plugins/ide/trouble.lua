return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  keys = {
    { "<leader>dd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Document diagnostics" },
    { "<leader>dD", "<cmd>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" },
    { "<leader>dl", "<cmd>Trouble lsp toggle<CR>", desc = "LSP" },
    { "<leader>do", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
    { "<leader>dq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix" },
    -- dT opens the todo list, defined in todo-comments.lua
    -- lsp
    { "gd", "<cmd>Trouble lsp_definitions focus=true<cr>", desc = "Goto Definition" },
    { "grr", "<cmd>Trouble lsp_references focus=true<cr>", desc = "Goto References" },
    { "gri", "<cmd>Trouble lsp_implementations focus=true<cr>", desc = "Goto Implementation" },
    { "gt", "<cmd>Trouble lsp_type_definitions focus=true<cr>", desc = "Goto Type Definition" },
  },
  opts = {},
}
