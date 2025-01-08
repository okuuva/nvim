return {
  "rcarriga/nvim-notify",
  opts = {
    fps = 60,
    timeout = 2000,
    top_down = false,
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    -- set notify plugin as default notify function
    vim.notify = notify
  end,
}
