---@module "snacks"
---@module "worktrees"

---@type LazyPluginSpec
return {
  "worktrees.nvim",
  specs = {
    "snacks.nvim",
    -- stylua: ignore
    keys = {
      ---@diagnostic disable-next-line: undefined-field
      { "<leader>gw", function() Snacks.picker.worktrees() end, desc = "List Worktrees" },
      ---@diagnostic disable-next-line: undefined-field
      { "<leader>gW", function() Snacks.picker.worktrees_new() end, desc = "New Worktree" },
    },
    ---@return snacks.Config
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          sources = {
            worktrees = {
              title = "Worktrees",
              layout = { preset = "select", preview = false },
              ---@type snacks.picker.finder
              finder = function(opts, filter)
                local worktrees_list, number_of_worktrees = require("worktrees.git").get_worktrees()
                if not worktrees_list or number_of_worktrees == 0 then
                  worktrees_list = {}
                end
                local current = require("worktrees.git").get_worktree_root() or ""

                ---@async
                ---@param cb async fun(item: snacks.picker.finder.Item)
                return function(cb)
                  for i, worktree in ipairs(worktrees_list) do
                    local item = {
                      idx = i,
                      file = worktree.path,
                      text = worktree.name,
                      path = worktree.path,
                      branch = worktree.branch,
                      current = vim.fs.normalize(current) == vim.fs.normalize(worktree.path),
                    }

                    cb(item)
                  end
                end
              end,
              format = function(item, picker)
                local a = Snacks.picker.util.align
                local ret = {} ---@type snacks.picker.Highlight[]
                if item.current then
                  ret[#ret + 1] = { a("", 2), "SnacksPickerGitBranchCurrent" }
                else
                  ret[#ret + 1] = { a("", 2), "SnacksPickerGitBranch" }
                end
                ret[#ret + 1] = { " " }
                Snacks.picker.highlight.format(item, a(item.text, 10), ret)
                ret[#ret + 1] = { " " }
                local branch = "[" .. item.branch:gsub("refs/heads/", "") .. "]"
                if item.current then
                  ret[#ret + 1] = { a(branch, 10), "SnacksPickerGitBranchCurrent" }
                else
                  ret[#ret + 1] = { a(branch, 10), "SnacksPickerGitBranch" }
                end
                ret[#ret + 1] = { " " }
                Snacks.picker.highlight.format(item, item.path, ret)
                return ret
              end,
              win = {
                input = {
                  keys = {
                    ["<C-x>"] = { "delete", mode = { "i", "n" } },
                  },
                },
              },
              actions = {
                ---@param picker snacks.Picker
                delete = function(picker)
                  local items = picker:selected({ fallback = true })
                  local worktrees = #items > 1 and " worktrees?" or " worktree?"
                  vim.ui.select(
                    { "Yes", "No" },
                    { prompt = "Really want to delete " .. #items .. worktrees },
                    function(choise)
                      if choise == "Yes" then
                        for _, item in ipairs(items) do
                          local current_worktree_path = require("worktrees.git").get_worktree_root() or ""
                          if vim.fs.normalize(current_worktree_path) ~= vim.fs.normalize(item.path) then
                            require("worktrees").utils.delete_worktree(item.path)
                          else
                            vim.notify("Cannot delete current worktree", vim.log.levels.ERROR)
                          end
                        end
                        picker:find()
                      end
                    end
                  )
                end,
              },
              confirm = function(picker, item)
                picker:close()
                if item == nil then
                  return vim.notify("No worktree selected", vim.log.levels.WARN)
                end
                if item.current then
                  return vim.notify("Selected worktree already active", "info")
                end
                return require("worktrees").utils.switch_worktree(item.path)
              end,
            },
            worktrees_new = {
              title = "New Worktree",
              finder = "git_branches",
              format = "git_branch",
              preview = "git_log",
              win = {
                input = {
                  keys = {
                    ["<C-n>"] = { "new", mode = { "i", "n" } },
                  },
                },
              },
              actions = {
                ---@param picker snacks.Picker
                new = function(picker)
                  picker:close()
                  local branch = picker.finder.filter.pattern
                  require("worktrees").utils.create_worktree("", branch, true)
                end,
              },
              ---@param picker snacks.Picker
              ---@param item? snacks.picker.Item
              confirm = function(picker, item)
                picker:close()
                local branch = item ~= nil and item.branch or picker.finder.filter.pattern
                require("worktrees").utils.create_worktree("", branch, true)
              end,
            },
          },
        },
      })
    end,
  },
  optional = true,
}
