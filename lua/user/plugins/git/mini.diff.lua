---@type LazyPluginSpec
return {
  "nvim-mini/mini.diff",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  -- stylua: ignore
  keys = {
    { "<leader>gtd", function() require("mini.diff").toggle_overlay(0) end, desc = "Diff overlay" },
  },
  opts = {
    view = {
      style = "sign",
      signs = { add = "", change = "", delete = "" },
      priority = 1,
    },
    mappings = {
      -- Apply hunks inside a visual/operator region
      apply = "gh",

      -- Reset hunks inside a visual/operator region
      reset = "gH",

      -- Hunk range textobject to be used inside operator
      -- Works also in Visual mode if mapping differs from apply and reset
      textobject = "gh",

      -- Go to hunk range in corresponding direction
      goto_first = "[H",
      goto_prev = "[h",
      goto_next = "]h",
      goto_last = "]H",
    },
    options = {
      wrap_goto = true,
    },
  },
}
