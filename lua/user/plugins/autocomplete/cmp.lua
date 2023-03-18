return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  -- load cmp on InsertEnter
  event = "InsertEnter",
  -- these dependencies will only be loaded when cmp loads
  -- dependencies are always lazy-loaded unless specified otherwise
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "doxnit/cmp-luasnip-choice", -- snippet completions
    "bydlw98/cmp-env",
    { -- plugin to autocomplete plugins. compleception?
      "KadoBOT/cmp-plugins",
      opts = {
        files = {
          "lua/user/plugins",
        },
      },
    },
    { "hrsh7th/cmp-nvim-lua", ft = "lua" },
    { "mtoohey31/cmp-fish", ft = "fish" },
    "onsails/lspkind.nvim", -- fancy icons
    "nvim-autopairs",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    --   פּ ﯟ   some other good icons
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
          luasnip.filetype_extend("python", { "django" })
          luasnip.filetype_extend("vue", { "vue" })
        end,
      },
      mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, }),
      },
      formatting = {
        -- fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({

          -- defines how annotations are shown
          -- default: symbol
          -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
          mode = "symbol_text",
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          menu = {
            nvim_lsp = "[LSP]",
            nvim_lua = "[NVIM LUA]",
            luasnip = "[Snippet]",
            fish = "[fish]",
            env = "[ENV]",
            plugins = "[Plugins]",
            buffer = "[Buffer]",
            path = "[Path]",
            nerdfont = "[NerdFont]",
          },
          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          -- before = function(entry, vim_item)
          --   return vim_item
          -- end,
        }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "fish" },
        { name = "env" },
        { name = "plugins" },
        { name = "buffer" },
        { name = "path" },
      },
      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
    })
  end,
}
