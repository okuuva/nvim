---@param language string
---@return string[]
local function _generate_array(language)
  return {
    language .. "/**/*.json",
    language .. "/**/*.lua",
    "**/" .. language .. ".json",
    "**/" .. language .. ".lua",
  }
end

---@vararg string
---@return string[]
local function generate_language_pattern_array(...)
  local lang_patterns = {}
  for _, language in ipairs({ ... }) do
    vim.list_extend(lang_patterns, _generate_array(language))
  end
  return lang_patterns
end

local lang_patterns = {
  javascript = generate_language_pattern_array("javascript", "mise"),
  python = generate_language_pattern_array("python", "mise"),
  shell = generate_language_pattern_array("sh", "mise"),
  vcs = generate_language_pattern_array("gitcommit"),
}

-- TODO: figure out how to dynamically strip the comment prefix from the mise snippet body text

---@type LazyPluginSpec
return {
  "nvim-mini/mini.snippets",
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = function(_, opts)
    local gen_loader = require("mini.snippets").gen_loader
    opts.snippets = {
      gen_loader.from_runtime("allFiletypes.json"),
      gen_loader.from_runtime("global.json"),
      gen_loader.from_lang({
        lang_patterns = {
          sh = lang_patterns.shell,
          bash = lang_patterns.shell,
          zsh = lang_patterns.shell,
          jjdescription = lang_patterns.vcs,
        },
      }),
    }
  end,
}
