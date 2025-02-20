return {
  "chrisgrieser/nvim-origami",
  event = "BufReadPost", -- later or on keypress would prevent saving folds
  opts = {
    keepFoldsAcrossSessions = false, -- this being true sometimes breaks folds
    hOnlyOpensOnFirstColumn = true,
  },
}
