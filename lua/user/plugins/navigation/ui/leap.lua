return {
  "ggandor/leap.nvim",
  keys = {
    { "s", "<Plug>(leap)", mode = { "n", "x", "o" }, desc = "Leap" },
    { "S", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from window" },
  },
  cond = false,
  lazy = false,
  dependencies = { "tpope/vim-repeat" },
  opts = {
    highlight_unlabeled_phase_one_targets = true,
  },
}
