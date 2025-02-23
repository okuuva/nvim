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
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    "bydlw98/cmp-env",
    { "mtoohey31/cmp-fish", ft = "fish" },
    "chrisgrieser/cmp-nerdfont",
    "onsails/lspkind.nvim", -- fancy icons
    "lukas-reineke/cmp-under-comparator",
    -- "nvim-autopairs",
    "LuaSnip",
    {
      "zbirenbaum/copilot-cmp",
      dependencies = { "copilot.lua" },
      config = true,
      cond = require("user.util").ai_helpers_allowed(),
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    require("luasnip.loaders.from_vscode").lazy_load()

    -- 󰃐 󰆩 󰙅 󰛡  󰅲 some other good icons
    ---@diagnostic disable-next-line: missing-fields
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
          luasnip.filetype_extend("python", { "django" })
          luasnip.filetype_extend("vue", { "vue" })
        end,
      },
      mapping = {
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "i", "c" }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),

        -- safe enter select with luasnip support
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({ select = false })
              end
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm(),
          c = function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm()
              end
            else
              fallback()
            end
          end,
        }),

        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s", "c" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s", "c" }),
      },
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = lspkind.cmp_format({
          -- defines how annotations are shown
          -- default: symbol
          -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
          mode = "symbol_text",
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          symbol_map = {
            Copilot = "",
            Codeium = "",
          },
          menu = {
            copilot = "[Copilot]",
            lazydev = "[LazyDev]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            codeium = "[Codeium]",
            fish = "[fish]",
            env = "[ENV]",
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
      ---@diagnostic disable-next-line: missing-fields
      sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          require("cmp-under-comparator").under,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      sources = {
        {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        },
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "codeium" },
        { name = "luasnip" },
        { name = "fish" },
        { name = "env" },
        { name = "buffer" },
        { name = "path" },
        { name = "nerdfont" },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
