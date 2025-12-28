local function generate_lang_pattern_array(language)
  return {
    language .. "/**/*.json",
    language .. "/**/*.lua",
    "**/" .. language .. ".json",
    "**/" .. language .. ".lua",
  }
end

local lang_patterns = {
  shell = generate_lang_pattern_array("sh"),
  vcs = generate_lang_pattern_array("gitcommit"),
}

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
      gen_loader.from_file(vim.fn.stdpath("config") .. "/snippets/allFiletypes.json"),
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
