return {
  -- TODO: switch back to original if the PR ever gets merged
  -- see https://github.com/brenoprata10/nvim-highlight-colors/pull/169
  -- "brenoprata10/nvim-highlight-colors", -- highlight hex colors
  "neckbeard-69/nvim-highlight-colors", -- highlight hex colors
  branch = "feat/add-oklch-support",
  event = "BufEnter",
  init = function()
    vim.opt.termguicolors = true
  end,
  opts = {
    render = "background", -- or 'foreground' or 'first_column'
    enable_named_colors = true,
    enable_tailwind = true,
  },
}
