return {
  "harrisoncramer/gitlab.nvim",
  version = "^2.0.0",
  event = "VeryLazy",
  dependencies = {
    "nui.nvim",
    "plenary.nvim",
    "diffview.nvim",
    "nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
    {
      "topaxi/pipeline.nvim",
      keys = {
        { "<leader>glp", "<cmd>Pipeline<cr>", desc = "Pipelines" },
      },
      optional = true,
    },
  },
  build = function()
    require("gitlab.server").build(true)
  end, -- Builds the Go binary
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>glb", function() require("gitlab").choose_merge_request() end, desc = "Choose MR" },
    { "<leader>glr", function() require("gitlab").review() end, desc = "Review" },
    { "<leader>gls", function() require("gitlab").summary() end, desc = "Summary" },
    { "<leader>glA", function() require("gitlab").approve() end, desc = "Approve" },
    { "<leader>glR", function() require("gitlab").revoke() end, desc = "Revoke approval" },
    { "<leader>glc", function() require("gitlab").create_comment() end, desc = "Comment" },
    { "<leader>glc", function() require("gitlab").create_multiline_comment() end, mode = "v", desc = "Comment" },
    { "<leader>glC", function() require("gitlab").create_comment_suggestion() end, mode = "v", desc = "Suggestion" },
    { "<leader>glO", function() require("gitlab").create_mr() end, desc = "Create MR" },
    { "<leader>glm", function() require("gitlab").move_to_discussion_tree_from_diagnostic() end, desc = "Move to Discussion Tree" },
    { "<leader>gln", function() require("gitlab").create_note() end, desc = "Create note" },
    { "<leader>gld", function() require("gitlab").toggle_discussions() end, desc = "Toggle discussions" },
    { "<leader>glaa", function() require("gitlab").add_assignee() end, desc = "Add" },
    { "<leader>glad", function() require("gitlab").delete_assignee() end, desc = "Delete" },
    { "<leader>glla", function() require("gitlab").add_label() end, desc = "Add" },
    { "<leader>glld", function() require("gitlab").delete_label() end, desc = "Delete" },
    { "<leader>glra", function() require("gitlab").add_reviewer() end, desc = "Add" },
    { "<leader>glrd", function() require("gitlab").delete_reviewer() end, desc = "Delete" },
    -- { "<leader>glp", function() require("gitlab").pipeline() end, desc = "Pipelines" },
    { "<leader>glo", function() require("gitlab").open_in_browser() end, desc = "Open in browser" },
    { "<leader>glM", function() require("gitlab").merge() end, desc = "Merge" },
    { "<leader>glu", function() require("gitlab").copy_mr_url() end, desc = "Copy MR url" },
    { "<leader>glP", function() require("gitlab").publish_all_drafts() end, desc = "Publish all drafts" },
    { "<leader>glD", function() require("gitlab").toggle_draft_mode() end, desc = "Toggle draft mode" },
 },
}
