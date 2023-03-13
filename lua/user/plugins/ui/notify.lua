return {
  "rcarriga/nvim-notify",
  name = "notify",
  config = function()
    local notify = require("notify")
    notify.setup({
      background_colour = "Normal",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 5000,
      top_down = true,
    })

    -- set notify plugin as default notify function
    vim.notify = notify
  end,
  lazy = true,
}
