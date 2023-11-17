return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  keys = {
    { "<leader>a", "<cmd>Alpha<cr>", desc = "Dashboard" },
  },
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
      dashboard.button("s", "󰚝  Find session", ":Telescope persisted theme=dropdown<CR>"),
      dashboard.button("r", "󰄉  Recently used files", ":Telescope oldfiles <CR>"),
      dashboard.button("t", "󰊄  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("e", "  Edit configuration", ":e ~/.config/nvim/init.lua <CR>"),
      dashboard.button("c", "󰜺  Close dashboard", ":Bdelete <CR>"),
      dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
    }

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    dashboard.opts.opts.noautocmd = true
    dashboard.opts.opts.autostart = false

    require("alpha").setup(dashboard.opts)
  end,
}
