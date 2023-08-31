local changed_on_branch = function()
  local previewers = require("telescope.previewers")
  local pickers = require("telescope.pickers")
  local sorters = require("telescope.sorters")
  local finders = require("telescope.finders")
  pickers
    .new({}, {
      results_title = "Modified in current branch",
      finder = finders.new_oneshot_job({
        "git",
        "diff",
        "--name-only",
        "--diff-filter=ACMR",
        "origin...",
      }, {}),
      sorter = sorters.get_fuzzy_file(),
      previewer = previewers.new_termopen_previewer({
        get_command = function(entry)
          return {
            "git",
            "diff",
            "--diff-filter=ACMR",
            "origin...",
            "--",
            entry.value,
          }
        end,
      }),
    })
    :find()
end

return {
  "nvim-telescope/telescope.nvim",
  version = "^0.1.1",
  cmd = "Telescope",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "benfowler/telescope-luasnip.nvim",
  },
  keys = {
    -- search
    { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Open Buffers" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sf", "<cmd>Telescope find_files hidden=true<cr>", desc = "Files" },
    { "<leader>sh", "<cmd>Telescope help_tags theme=ivy<cr>", desc = "Help" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>sm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sn", "<cmd>Telescope notify<cr>", desc = "Notifications" },
    { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    { "<leader>sR", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>ss", "<cmd>Telescope luasnip<cr>", desc = "Snippets" },
    { "<leader>sS", "<cmd>Telescope persisted theme=dropdown<cr>", desc = "Sessions" },
    { "<leader>st", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Text" },
    { "<leader>sy", "<cmd>Telescope yank_history<cr>", desc = "Yank history" },
    -- git
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Switch branch" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
    { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Checkout commit (for current file)" },
    -- stylua: ignore
    { "<leader>gm", function() changed_on_branch() end, desc = "Modified files" },
    -- lsp
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Search Document Symbols" },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Search Workspace Symbols" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local telescopeConfig = require("telescope.config")
    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")
    -- trim indentation from the preview
    table.insert(vimgrep_arguments, "--trim")

    telescope.setup({
      defaults = {

        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        vimgrep_arguments = vimgrep_arguments,

        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            ["<C-c>"] = actions.close,
            ["<esc>"] = actions.close,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-l>"] = actions.complete_tag,
            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
          },

          n = {
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["?"] = actions.which_key,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--color", "never", "--strip-cwd-prefix" },
        },
        git_branches = {
          mappings = {
            i = { ["<cr>"] = actions.git_switch_branch },
          },
        },
      },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("luasnip")
    telescope.load_extension("persisted")
    telescope.load_extension("notify")
    telescope.load_extension("noice")
    telescope.load_extension("projects")
    telescope.load_extension("yank_history")
  end,
}
