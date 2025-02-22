return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  cond = true,
  -- dependencies = {
  --   -- apparently this is supposed to just merge with the main spec for nvim-cmp. magic!
  --   { -- optional cmp completion source for require statements and module annotations
  --     "hrsh7th/nvim-cmp",
  --     opts = function(_, opts)
  --       opts.sources = opts.sources or {}
  --       table.insert(opts.sources, {
  --         name = "lazydev",
  --         group_index = 0, -- set group index to 0 to skip loading LuaLS completions
  --       })
  --     end,
  --   },
  -- },
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
      { path = "lazy.nvim", words = { "opts", "config" } },
    },
  },
}
