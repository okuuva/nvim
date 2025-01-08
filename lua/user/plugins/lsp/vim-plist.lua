return {
  "darfink/vim-plist",
  ft = { "plist", "xml", "json" },
  init = function()
    vim.g.plist_display_format = "json"
  end,
}
