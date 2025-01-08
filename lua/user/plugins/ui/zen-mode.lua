return {
  cmd = { "ZenMode" },
  "okuuva/zen-mode.nvim",
  branch = "make-fcs-configurable",
  opts = {
    window = {
      width = 110,
      height = 1,
      options = {
        fillchars = vim.o.fillchars,
      },
    },
    -- see https://github.com/b0o/incline.nvim/discussions/77 for enabling incline for zen mode window
    -- callback where you can add custom code when the Zen window opens
    on_open = function()
      local status_ok, incline = pcall(require, "incline")
      if status_ok then
        incline.disable()
      end
    end,
    -- callback where you can add custom code when the Zen window closes
    on_close = function()
      local status_ok, incline = pcall(require, "incline")
      if status_ok then
        incline.enable()
      end
    end,
  },
}
