local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

return {
  name = "darker",
  meta = {
    url = "https://github.com/akaihola/darker",
    description = "For when you want to use black but really can't",
  },
  method = FORMATTING,
  filetypes = { "python" },
  generator = h.formatter_factory({
    args = {
      "--stdout",
      "$FILENAME"
    },
    command = "darker",
  }),
}
