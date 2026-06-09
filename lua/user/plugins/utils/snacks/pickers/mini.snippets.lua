---@module "mini.snippets"

local function get_all_snippets()
  local loader = MiniSnippets.gen_loader.from_lang({
    lang_patterns = { [""] = { "**/*.json", "**/*.lua" } },
    silent = true,
  })
  return MiniSnippets.default_prepare({ loader }, { context = { buf_id = 0, lang = "" } })
end

-- example: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#trouble
-- see https://github.com/folke/snacks.nvim/discussions/1804#discussioncomment-12955956
---@type LazyPluginSpec
return {
  "mini.snippets",
  -- stylua: ignore
  keys = {
    ---@diagnostic disable-next-line: undefined-field
    { "<leader>ss", function() Snacks.picker.mini_snippets() end, desc = "Snippets" },
  },
  specs = {
    "snacks.nvim",
    ---@return snacks.Config
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          sources = {
            ---@type snacks.picker.Config
            mini_snippets = {
              title = "Snippets",
              supports_live = false,
              sort = { fields = { "ft:desc", "score:desc", "#text", "idx" } },
              preview = "preview",
              format = function(item)
                return {
                  { item.name, item.ft == "" and "Conceal" or "DiagnosticWarn" },
                  { item.description },
                }
              end,
              finder = function()
                local snippets = {}
                local align_1 = 0
                for _, snip in ipairs(get_all_snippets()) do
                  if snip.prefix and snip.prefix ~= "" then
                    snip.ft = ""
                    snippets[snip.prefix] = snip
                    align_1 = math.max(align_1, #snip.prefix)
                  end
                end
                for _, snip in ipairs(MiniSnippets.expand({ match = false, insert = false }) or {}) do
                  snip.ft = vim.bo.ft
                  snippets[snip.prefix] = snip
                end
                local items = {}
                for _, snip in pairs(snippets) do
                  local name = Snacks.picker.util.align(snip.prefix, align_1 + 1)
                  table.insert(items, {
                    text = table.concat({ name, snip.desc or "", snip.body }, " "),
                    name = name,
                    description = snip.desc,
                    prefix = snip.prefix,
                    ft = snip.ft,
                    preview = {
                      ft = snip.ft,
                      text = snip.body,
                    },
                    snippet = snip,
                  })
                end
                table.sort(items, function(a, b)
                  if a.ft == b.ft then
                    return a.name < b.name
                  end
                  return a.ft > b.ft
                end)
                return items
              end,
              confirm = function(picker, item)
                picker:close()
                if item then
                  MiniSnippets.default_insert(item.snippet)
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
