local grep_opts = {
  hidden = true,
  follow = true,
}
---@type LazyPluginSpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    -- see: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#general
    -- Top Pickers & Explorer
    { "<leader>/", function() Snacks.picker.grep(grep_opts) end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    -- git
    { "<leader>sgb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>sgl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>sgL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>sgs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>sgS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>sgd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>sgf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    -- Grep
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers(grep_opts) end, desc = "Grep Open Buffers" },
    { "<leader>sw", function() Snacks.picker.grep_word(grep_opts) end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sL", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sn", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Plugin Spec" },
    { "<leader>sP", function() Snacks.picker.pickers() end, desc = "Pickers" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    -- LSP
    { "<leader>ld", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "<leader>lD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "<leader>lr", function() Snacks.picker.lsp_references() end, desc = "References" },
    { "<leader>li", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
  },
  ---@type snacks.Config
  opts = {
    picker = {
      on_show = function(self)
        local pos = self.layout and self.layout.root and self.layout.root.opts.position
        if pos == "bottom" then
          require("edgy").close("bottom")
        end
      end,
      matcher = {
        frecency = true,
      },
      ---@type table<string, snacks.picker.Config>
      kinds = {
        sidekick_cli = {
          layout = { preset = "default" },
          preview = function(ctx)
            local state = ctx.item.item
            if state and state.session and state.session.dump then
              local content = state.session:dump()
              if content then
                ctx.preview:set_lines(vim.split(content, "\n"))
                return true
              end
            end
            ctx.preview:reset()
          end,
        },
      },
      sources = {
        grep = {
          layout = {
            preset = "bottom",
          },
        },
        help = {
          layout = {
            preset = "bottom",
          },
        },
      },
      actions = {
        debug = function(...)
          dd(...)
        end,
      },
      win = {
        input = {
          keys = {
            ["<C-t>"] = false,
            ["<C-t>f"] = { "toggle_follow", mode = { "i", "n" } },
            ["<C-t>h"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<C-t>i"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<C-t>m"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<C-t>p"] = { "toggle_preview", mode = { "i", "n" } },
            ["<PageUp>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<PageDown>"] = { "preview_scroll_down", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["p"] = "put",
            ["y"] = "yank",
            ["<PageUp>"] = "preview_scroll_up",
            ["<PageDown>"] = "preview_scroll_down",
          },
        },
      },
    },
  },
}
