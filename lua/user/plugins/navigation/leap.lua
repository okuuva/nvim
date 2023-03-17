return {
  "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "s", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
  dependencies = { "tpope/vim-repeat" },
  config = function()
    require("leap").setup({
      max_phase_one_targets = nil,
      highlight_unlabeled_phase_one_targets = false,
      max_highlighted_traversal_targets = 10,
      case_sensitive = false,
      -- Sets of characters that should match each other.
      -- Obvious candidates are braces and quotes ('([{', ')]}', '`"\'').
      equivalence_classes = { " \t\r\n" },
      -- Leaving the appropriate list empty effectively disables "smart" mode,
      -- and forces auto-jump to be on or off.
      -- commented these out because I don't understand how this is supposed to work
      -- safe_labels = { 's', 'f', 'n', 'u', 't', . . . },
      -- labels = { 's', 'f', 'n', 'j', 'k', . . . },
      special_keys = {
        repeat_search = "<enter>",
        next_phase_one_target = "<enter>",
        next_target = { "<enter>", ";" },
        prev_target = { "<tab>", "," },
        next_group = "<space>",
        prev_group = "<tab>",
        multi_accept = "<enter>",
        multi_revert = "<backspace>",
      },
    })

    require("leap").set_default_keymaps()
  end,
}
