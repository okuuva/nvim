return {
  "ggandor/leap.nvim",
  keys = {
    { "s", "<Plug>(leap-forward)", mode = { "n", "x", "o" }, desc = "Leap forward" },
    { "S", "<Plug>(leap-backward)", mode = { "n", "x", "o" }, desc = "Leap backward" },
    { "gS", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from windows" },
  },
  lazy = false,
  dependencies = { "tpope/vim-repeat" },
  opts = {
    highlight_unlabeled_phase_one_targets = true,
  },
}
