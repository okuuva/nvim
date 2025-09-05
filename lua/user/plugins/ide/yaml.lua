---@type LazyPluginSpec
return {
  "cuducos/yaml.nvim",
  ft = { "yaml" },
  dependencies = {
    "folke/snacks.nvim",
    {
      "folke/which-key.nvim",
      optional = true,
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>sY", function() require("yaml_nvim").snacks() end, desc = "YAML" },
    { "<leader>yv", function() require("yaml_nvim").view() end, desc = "View key/value" },
    { "<leader>yyk", function() require("yaml_nvim").yank_key() end, desc = "Key" },
    { "<leader>yyv", function() require("yaml_nvim").yank_value() end, desc = "Value" },
    { "<leader>yyy", function() require("yaml_nvim").yank() end, desc = "Key & value" },
  },
  init = function()
    require("user.util").wk_add({
      { "<leader>y", group = "YAML" },
      { "<leader>yy", group = "Yank" },
    })
  end,
  opts = {},
}
