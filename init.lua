require("user.config")
require("lazy").setup("user.plugins", {
  defaults = {
    lazy = true,
  },
  concurrency = 50,
})
