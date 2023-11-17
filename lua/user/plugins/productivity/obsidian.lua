return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = { "BufReadPre " .. vim.fn.expand("~") .. "/obsidian/**.md" },
  keys = {
    { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in app" },
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
    { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find note" },
    { "<leader>oF", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks to this note" },
    { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Daily note" },
    { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Yesterday's note" },
    { "<leader>oT", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
    { "<leader>ow", "<cmd>ObsidianWorkspace<cr>", desc = "Show workspace" },
    { "<leader>ol", "<cmd>ObsidianLink<cr>", desc = "Link to an existing note", mode = "x" },
    { "<leader>oL", "<cmd>ObsidianLinkNew<cr>", desc = "Link to a new note", mode = "x" },
  },
  dependencies = {
    "plenary.nvim",
    "nvim-cmp",
    "telescope.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/Obsidian/Work",
      },
      {
        name = "personal",
        path = "~/Obsidian/Personal",
      },
    },

    -- Optional, set to true to use the current directory as a vault; otherwise,
    -- the first workspace is opened by default
    detect_cwd = false,

    -- Optional, if you keep notes in a specific subdirectory of your vault.
    notes_subdir = "notes",

    -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
    -- levels defined by "vim.log.levels.*" or nil, which is equivalent to DEBUG (1).
    log_level = vim.log.levels.INFO,

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "notes/dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },

    completion = {
      -- If using nvim-cmp, otherwise set to false
      nvim_cmp = true,
      -- Trigger completion at 2 chars
      min_chars = 2,
      -- Where to put new notes created from completion. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "current_dir",

      -- Whether to add the output of the node_id_func to new notes in autocompletion.
      -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
      prepend_note_id = true,
    },
    mappings = {},
    -- mappings = {
    --   -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    --   ["gf"] = require("obsidian.mapping").gf_passthrough(),
    -- },
    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      vim.fn.jobstart({ "open", url }) -- Mac OS
      -- vim.fn.jobstart({"xdg-open", url})  -- linux
    end,
    finder = "telescope.nvim",
  },
}
