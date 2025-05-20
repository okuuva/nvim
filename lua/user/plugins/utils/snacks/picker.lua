---@type LazyPluginSpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    -- search
    { "<leader>sB", function() Snacks.picker.buffers() end, desc = "Open Buffers" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sf", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sm", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sp", function() Snacks.picker.pickers() end, desc = "Pickers" },
    { "<leader>sr", function() Snacks.picker.recent() end, desc = "Recent Files" },
    { "<leader>st", function() Snacks.picker.grep() end, desc = "Text" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- lsp
    { "<leader>sd", function() Snacks.picker.lsp_symbols() end, desc = "Document Symbols" },
    { "<leader>sD", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
  },
  ---@type snacks.Config
  opts = {
    picker = {
      matcher = {
        frecency = true,
      },
      sources = {
        grep = {
          layout = {
            preset = "bottom",
          },
        },
        help = {
          layout = {
            preset = "bottom",
          },
        },
      },
      actions = {
        debug = function(...)
          dd(...)
        end,
      },
      win = {
        list = {
          keys = {
            ["p"] = "put",
            ["y"] = "yank",
          },
        },
      },
    },
  },
}
