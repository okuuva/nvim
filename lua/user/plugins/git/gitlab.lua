return {
  "harrisoncramer/gitlab.nvim",
  version = "^1.0.0",
  event = "VeryLazy",
  dependencies = {
    "nui.nvim",
    "plenary.nvim",
    "diffview.nvim",
    "dressing.nvim", -- Recommended but not required. Better UI for pickers.
  },
  build = function()
    require("gitlab.server").build(true)
  end, -- Builds the Go binary
  opts = {},
  -- stylua: ignore
  keys = {
    { "glr", function() require("gitlab").review() end, desc = "Review" },
    { "gls", function() require("gitlab").summary() end, desc = "Summary" },
    { "glA", function() require("gitlab").approve() end, desc = "Approve" },
    { "glR", function() require("gitlab").revoke() end, desc = "Revoke approval" },
    { "glc", function() require("gitlab").create_comment() end, desc = "Comment" },
    { "glc", function() require("gitlab").create_multiline_comment() end, mode = "v", desc = "Comment" },
    { "gls", function() require("gitlab").create_comment_suggestion() end, mode = "v", desc = "Suggestion" },
    { "gln", function() require("gitlab").create_note() end, desc = "Create note" },
    { "gld", function() require("gitlab").toggle_discussions() end, desc = "Toggle discussions" },
    { "glp", function() require("gitlab").pipeline() end, desc = "Pipelines" },
    { "glP", function() require("gitlab").print_settings() end, desc = "Print settings" },
    { "glo", function() require("gitlab").open_in_browser() end, desc = "Open in browser" },
    { "glaa", function() require("gitlab").add_assignee() end, desc = "Add" },
    { "glad", function() require("gitlab").delete_assignee() end, desc = "Delete" },
    { "glra", function() require("gitlab").add_reviewer() end, desc = "Add" },
    { "glrd", function() require("gitlab").delete_reviewer() end, desc = "Delete" },
 },
}
