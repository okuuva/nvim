---@type vim.lsp.Config
return {
  filetypes = { "json", "jsonc", "hujson" },
  ---@module "codesettings"
  ---@type lsp.jsonls
  settings = {
    json = {
      -- disable formatting since we have conform.nvim
      format = {
        enable = false,
      },
      schemas = vim.tbl_deep_extend("force", require("schemastore").json.schemas(), {
        {
          fileMatch = { "*.hujson" },
          schema = {
            allowComments = true,
            allowTrailingCommas = true,
          },
        },
      }),
      validate = {
        enable = true,
      },
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  },
}
