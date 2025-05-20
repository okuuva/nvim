-- example: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#trouble
-- see https://github.com/folke/snacks.nvim/discussions/1804#discussioncomment-12955956
---@type LazyPluginSpec
return {
  "LuaSnip",
  specs = {
    "snacks.nvim",
    -- stylua: ignore
    keys = {
      ---@diagnostic disable-next-line: undefined-field
      { "<leader>ss", function() Snacks.picker.snippets() end, desc = "Snippets" },
    },
    ---@return snacks.Config
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          sources = {
            snippets = {
              supports_live = false,
              preview = "preview",
              format = function(item)
                return {
                  { item.name, item.ft == "" and "Conceal" or "DiagnosticWarn" },
                  { item.description },
                }
              end,
              finder = function()
                local snippets = {}
                for _, snip in ipairs(require("luasnip").get_snippets().all) do
                  snip.ft = ""
                  table.insert(snippets, snip)
                end
                for _, snip in ipairs(require("luasnip").get_snippets(vim.bo.ft)) do
                  snip.ft = vim.bo.ft
                  table.insert(snippets, snip)
                end
                local align_1 = 0
                for _, snip in pairs(snippets) do
                  align_1 = math.max(align_1, #snip.name)
                end
                local items = {}
                for _, snip in pairs(snippets) do
                  local docstring = snip:get_docstring()
                  if type(docstring) == "table" then
                    docstring = table.concat(docstring)
                  end
                  local name = Snacks.picker.util.align(snip.name, align_1 + 5)
                  local description = table.concat(snip.description)
                  description = name == description and "" or description
                  table.insert(items, {
                    text = name .. description,
                    name = name,
                    description = description,
                    trigger = snip.trigger,
                    ft = snip.ft,
                    preview = {
                      ft = snip.ft,
                      text = docstring,
                    },
                  })
                end
                return items
              end,
              confirm = function(picker, item)
                picker:close()
                --
                local expand = {}
                require("luasnip").available(function(snippet)
                  if snippet.trigger == item.trigger then
                    table.insert(expand, snippet)
                  end
                end)
                if #expand > 0 then
                  vim.cmd(":startinsert!")
                  vim.defer_fn(function()
                    require("luasnip").snip_expand(expand[1])
                  end, 50)
                else
                  Snacks.notify.warn("No snippet to expand")
                end
              end,
            },
          },
        },
      })
    end,
  },
  optional = true,
}
