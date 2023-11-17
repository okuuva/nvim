return {
  "harrisoncramer/gitlab.nvim",
  version = "^0.0.2",
  event = "VeryLazy",
  dependencies = {
    "nui.nvim",
    "plenary.nvim",
    "dressing.nvim", -- Recommended but not required. Better UI for pickers.
  },
  build = function()
    require("gitlab.server").build(true)
  end, -- Builds the Go binary
  opts = {
    reviewer = "diffview", -- The reviewer type ("delta" or "diffview")
  },
  -- stylua: ignore
  keys = {
    { "<leader>glr", function() require("gitlab").review() end, desc = "Review" },
    { "<leader>gls", function() require("gitlab").summary() end, desc = "Summary" },
    { "<leader>glA", function() require("gitlab").approve() end, desc = "Approve" },
    { "<leader>glR", function() require("gitlab").revoke() end, desc = "Revoke approval" },
    { "<leader>glc", function() require("gitlab").create_comment() end, desc = "Comment" },
    { "<leader>glc", function() require("gitlab").create_multiline_comment() end, mode = "v", desc = "Comment" },
    { "<leader>gls", function() require("gitlab").create_comment_suggestion() end, mode = "v", desc = "Suggestion" },
    { "<leader>gln", function() require("gitlab").create_note() end, desc = "Create note" },
    { "<leader>gld", function() require("gitlab").toggle_discussions() end, desc = "Toggle discussions" },
    { "<leader>glp", function() require("gitlab").pipeline() end, desc = "Pipelines" },
    { "<leader>glP", function() require("gitlab").print_settings() end, desc = "Print settings" },
    { "<leader>glo", function() require("gitlab").open_in_browser() end, desc = "Open in browser" },
    { "<leader>glaa", function() require("gitlab").add_assignee() end, desc = "Add" },
    { "<leader>glad", function() require("gitlab").delete_assignee() end, desc = "Delete" },
    { "<leader>glea", function() require("gitlab").add_reviewer() end, desc = "Add" },
    { "<leader>gled", function() require("gitlab").delete_reviewer() end, desc = "Delete" },
 },
}
