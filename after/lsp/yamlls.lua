---@type vim.lsp.Config
return {
  capabilities = {
    workspace = {
      didChangeConfiguration = {
        -- kubeschema.nvim relies on workspace.didChangeConfiguration to implement dynamic schema loading of yamlls.
        -- It is recommended to enable dynamicRegistration (it's also OK not to enable it, but warning logs will be
        -- generated from LspLog, but it will not affect the function of kubeschema.nvim)
        dynamicRegistration = true,
      },
    },
  },
  -- IMPORTANT!!! Set kubeschema's on_attch to yamlls so that kubeschema can dynamically and accurately match the
  -- corresponding schema file based on the yaml file content (APIVersion and Kind).
  on_attach = require("kubeschema").on_attach,
  on_new_config = function(new_config)
    new_config.settings.yaml = vim.tbl_deep_extend("force", new_config.settings.yaml or {}, {
      schemaStore = {
        enable = false,
      },
      -- Use other schemas from SchemaStore
      -- https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/api/json/catalog.json
      schemas = require("schemastore").yaml.schemas({}),
    })
  end,
  ---@module "codesettings"
  ---@type lsp.yamlls
  settings = {
    yaml = {
      completion = true,
      format = {
        enable = false,
      },
      hover = true,
      validate = true,
    },
  },
}
