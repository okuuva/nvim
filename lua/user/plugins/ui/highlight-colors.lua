return {
  "brenoprata10/nvim-highlight-colors", -- highlight hex colors
  event = "BufEnter",
  init = function ()
    vim.opt.termguicolors = true
  end,
  opts = {
    render = "background", -- or 'foreground' or 'first_column'
    enable_named_colors = true,
    enable_tailwind = true,
  },
}
