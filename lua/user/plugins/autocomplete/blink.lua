local function kind_icon(ctx)
  local icon = ctx.kind_icon
  if vim.tbl_contains({ "Path" }, ctx.source_name) then
    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
    if dev_icon then
      icon = dev_icon
    end
  else
    icon = require("lspkind").symbolic(ctx.kind, {
      mode = "symbol",
    })
  end

  return icon .. ctx.icon_gap
end

local function kind_highlight(ctx)
  local hl = ctx.kind_hl
  if vim.tbl_contains({ "Path" }, ctx.source_name) then
    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
    if dev_icon then
      hl = dev_hl
    end
  end
  return hl
end

-- higher number == more important
local source_priority = {
  lazydev = 100,
  obsidian = 65,
  obsidian_tags = 65,
  obsidian_new = 65,
  lsp = 50,
  dbee = 45,
  path = 40,
  snippets = 30,
  buffer = 20,
  fish = 15,
  nerdfont = 10,
  env = 1,
}

---@type LazyPluginSpec
return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    "nvim-web-devicons",
    "lspkind.nvim", -- fancy icons
    "lazydev.nvim",
    "LuaSnip",
    "nvim-scissors", -- snippet editor
    -- legacy cmp sources and the compatibility plugin
    {
      "saghen/blink.compat",
      version = "2.*",
    },
    "bydlw98/cmp-env",
    { "mtoohey31/cmp-fish", ft = "fish" },
    "chrisgrieser/cmp-nerdfont",
    {
      "MattiasMTS/cmp-dbee",
      dependencies = {
        { "kndndrj/nvim-dbee" },
      },
      ft = "sql", -- optional but good to have
      -- opts = {}, -- needed
    },
  },
  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source
  -- build = "nix run .#build-plugin",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = "none",
      ["<CR>"] = { "accept", "fallback" },
      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      ["<C-n>"] = {
        function(cmp)
          if vim.bo.filetype == "scissors-snippet" then
            return require("blink.cmp")["fallback"]()
          end
          if not cmp.is_menu_visible() then
            return cmp.show()
          end
        end,
        "select_next",
      },
      ["<C-p>"] = {
        function(cmp)
          if not cmp.is_menu_visible() then
            return cmp.show()
          end
        end,
        "select_prev",
      },
      ["<Tab>"] = {
        function(cmp)
          if vim.b._augment_suggestion and vim.b._augment_suggestion.lines then
            vim.schedule(vim.fn["augment#Accept"])
            return true
          elseif cmp.snippet_active() then
            return cmp.snippet_forward()
          end
        end,
        function() -- sidekick next edit suggestion
          local ok, sidekick = pcall(require, "sidekick")
          return ok and sidekick.nes_jump_or_apply() or false
        end,
        "fallback",
      },
      ["<Esc>"] = {
        "cancel",
        function()
          if vim.b._augment_suggestion and vim.b._augment_suggestion.lines then
            -- a hack to clear the suggestion. augment doesn't expose a public API for it but this does the trick
            vim.fn["augment#OnInsertLeavePre"]()
          end
        end,
        "fallback",
      },
    },
    cmdline = {
      keymap = { preset = "inherit" },
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
        menu = {
          auto_show = true,
        },
      },
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 50,
      },
      ghost_text = {
        enabled = false,
        show_without_selection = false,
      },
      list = {
        selection = {
          preselect = false,
        },
      },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
            { "source_name" },
          },
          components = {
            kind_icon = {
              text = kind_icon,
              -- Optionally, use the highlight groups from nvim-web-devicons
              -- You can also add the same function for `kind.highlight` if you want to
              -- keep the highlight groups in sync with the icons.
              highlight = kind_highlight,
            },
            kind = {
              highlight = kind_highlight,
            },
            source_name = {
              text = function(ctx)
                return "[" .. ctx.source_name .. "]"
              end,
            },
          },
        },
        scrollbar = false,
      },
    },
    fuzzy = {
      sorts = {
        "exact",
        function(a, b)
          local a_priority = source_priority[a.source_id] or 35
          local b_priority = source_priority[b.source_id] or 35
          if a_priority ~= b_priority then
            return a_priority > b_priority
          end
        end,
        "score",
        "sort_text",
      },
    },
    signature = {
      enabled = false,
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "env",
        "nerdfont",
      },
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
        fish = { inherit_defaults = true, "fish" },
        sql = { inherit_defaults = true, "dbee" },
      },
      providers = {
        -- always show buffer suggestions
        lsp = { fallbacks = {} },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        env = {
          name = "ENV",
          module = "blink.compat.source",
          score_offset = -10,
          opts = {
            cmp_name = "env",
          },
        },
        fish = {
          name = "Fish",
          module = "blink.compat.source",
          opts = {
            cmp_name = "fish",
          },
        },
        nerdfont = {
          name = "NerdFont",
          module = "blink.compat.source",
          opts = {
            cmp_name = "nerdfont",
          },
        },
        dbee = {
          name = "Dbee",
          module = "blink.compat.source",
          opts = {
            cmp_name = "dbee",
          },
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
