---@module "blink"
local long_date = "%A %B %-d, %Y"

---@type LazyPluginSpec
return {
  "obsidian-nvim/obsidian.nvim",
  version = "^3.7.8",
  lazy = true,
  event = { "BufReadPre " .. vim.fn.expand("~") .. "**/Obsidian/**.md" },
  keys = {
    { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in app" },
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
    { "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle checkbox" },
    { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find note" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks to this note" },
    { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Daily note" },
    { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Yesterday's note" },
    { "<leader>ot", "<cmd>ObsidianTomorrow<cr>", desc = "Tomorrow's note" },
    { "<leader>oT", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
    { "<leader>ow", "<cmd>ObsidianWorkspace<cr>", desc = "Show workspace" },
    { "<leader>ol", "<cmd>ObsidianLink<cr>", desc = "Link to an existing note", mode = "x" },
    { "<leader>oL", "<cmd>ObsidianLinkNew<cr>", desc = "Link to a new note", mode = "x" },
    { "<leader>so", "<cmd>ObsidianSearch<cr>", desc = "Obsidian notes" },
  },
  dependencies = {
    "plenary.nvim",
    "render-markdown.nvim", -- use render-markdown for UI instead of builtin rendering
    { "saghen/blink.cmp", optional = true },
  },
  opts = {
    completion = {
      nvim_cmp = false,
      blink = true,
    },

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "notes/dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = long_date,
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "Daily template.md",
    },

    -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
    -- levels defined by "vim.log.levels.*" or nil, which is equivalent to DEBUG (1).
    log_level = vim.log.levels.INFO,

    -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
    -- way then set 'mappings = {}'.
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },

    new_notes_location = "notes_subdir",

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- Optional, if you keep notes in a specific subdirectory of your vault.
    notes_subdir = "notes",

    picker = {
      name = "snacks.pick",
      note_mappings = {
        new = "<C-n>",
      },
    },

    preferred_link_style = "markdown",

    -- Optional, for templates (see below).
    templates = {
      subdir = "templates",
      substitutions = {
        long_date = function()
          return os.date(long_date)
        end,
      },
    },

    -- Use render-markdown for UI
    ui = { enable = false },

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
  },
}
