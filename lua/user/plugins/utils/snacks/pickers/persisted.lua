---@module "snacks"

---@type LazyPluginSpec
return {
  "persisted.nvim",
  keys = {
    ---@diagnostic disable-next-line: undefined-field
    { "<leader>sS", function() Snacks.picker.sessions() end, desc = "Sessions" },
  },
  specs = {
    "snacks.nvim",
    ---@return snacks.Config
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          sources = {
            sessions = {
              title = "Sessions",
              layout = { preset = "select", preview = false },
              ---@type snacks.picker.finder
              finder = function(opts, filter)
                local persisted = require("persisted")
                local config = require("persisted.config")
                local sessions = persisted.list()
                local current = persisted.current()

                ---@async
                ---@param cb async fun(item: snacks.picker.finder.Item)
                return function(cb)
                  for i, session in ipairs(sessions) do
                    local file = session:sub(#config.save_dir + 1, -5)
                    local dir, branch = unpack(vim.split(file, "@@", { plain = true }))
                    dir = dir:gsub("%%", "/")

                    local name = vim.fn.fnamemodify(dir, ":p:~")
                    if branch then
                      name = name .. " (" .. branch .. ")"
                    end

                    cb({
                      idx = i,
                      text = name,
                      file = dir,
                      session_path = session,
                      branch = branch,
                      current = session == current,
                    })
                  end
                end
              end,
              format = function(item, picker)
                local a = Snacks.picker.util.align
                local ret = {} ---@type snacks.picker.Highlight[]
                if item.current then
                  ret[#ret + 1] = { a("", 2), "SnacksPickerGitBranchCurrent" }
                else
                  ret[#ret + 1] = { a("", 2), "SnacksPickerDir" }
                end
                ret[#ret + 1] = { " " }
                Snacks.picker.highlight.format(item, item.text, ret)
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
                  local sessions = #items > 1 and " sessions?" or " session?"
                  vim.ui.select(
                    { "Yes", "No" },
                    { prompt = "Really want to delete " .. #items .. sessions },
                    function(choice)
                      if choice == "Yes" then
                        for _, item in ipairs(items) do
                          if item.current then
                            vim.notify("Cannot delete current session", vim.log.levels.ERROR)
                          else
                            vim.fn.delete(vim.fn.expand(item.session_path))
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
                  return vim.notify("No session selected", vim.log.levels.WARN)
                end
                if item.current then
                  return vim.notify("Selected session already active", vim.log.levels.INFO)
                end
                vim.fn.chdir(item.file)
                require("persisted").load()
              end,
            },
          },
        },
      })
    end,
  },
  optional = true,
}
