---@type LazyPluginSpec
return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install()
  end,
  cmd = { "Dbee" },
  -- using config here because many of the dbee settings use require("dbee").blah
  config = function()
    require("dbee").setup({
      sources = {
        require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
        require("dbee.sources").FileSource:new(vim.fn.stdpath("state") .. "/dbee/persistence.json"),
        require("dbee.sources").FileSource:new(vim.fn.getcwd() .. "/.dbee.json"),
      },
    })
  end,
}
