---@type LazyPluginSpec
return {
  "chrisgrieser/nvim-origami",
  event = "BufReadPost", -- later or on keypress would prevent saving folds
  commit = "6965856d2282", -- TODO: check if v2.0 could replace ufo
  -- stylua: ignore
  keys = {
    { "<Left>", function() require("origami").h() end },
    { "<Right>", function() require("origami").l() end }
  },
  opts = {
    foldkeymaps = {
      setup = false,
      hOnlyOpensOnFirstColumn = true,
    },
  },
}
