return {
  "linrongbin16/gitlinker.nvim",
  version = "^4.0.0",
  keys = {
    -- stylua: ignore
    { "<leader>gLy", "<cmd>GitLink<cr>", mode = { "n", "x" }, desc = "Copy git permalink to clipboard" },
    { "<leader>gLo", "<cmd>GitLink!<cr>", mode = { "n", "x" }, desc = "Open git permalink in browser" },
    { "<leader>gLb", "<cmd>GitLink blame<cr>", mode = { "n", "x" }, desc = "Copy git blame link to clipboard" },
    { "<leader>gLB", "<cmd>GitLink! blame<cr>", mode = { "n", "x" }, desc = "Open git blame link in browser" },
  },
  opts = function()
    return {
      -- print message in command line
      message = false,

      -- router bindings
      -- make gitlab urls play ball with self hosted instances as well
      router = {
        browse = {
          ["^gitlab%.*"] = require("gitlinker.routers").gitlab_browse,
        },
        blame = {
          ["^gitlab%.*"] = require("gitlinker.routers").gitlab_blame,
        },
      },
    }
  end,
}
