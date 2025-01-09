local function post_selection()
  require("paperplanes").post_selection(function(url, err)
    if url == nil then
      vim.notify(("paperplanes got no url back from provider: %s"):format(err), vim.log.levels.ERROR)
      return
    end
    local reg = require("user.util").opts("paperplanes.nvim").register or nil
    local msg_prefix = ""
    if reg ~= nil then
      vim.fn.setreg(reg, url)
      msg_prefix = ('"%s = '):format(reg)
    end
    vim.notify(("%s%s"):format(msg_prefix, url), vim.log.levels.INFO)
  end)
end

return {
  "rktjmp/paperplanes.nvim",
  keys = {
    { "<leader>PP", "<cmd>PP<cr>", desc = "Send buffer to pastebin" },
    { "<leader>PP", post_selection, mode = "x", desc = "Send selection to pastebin" },
  },
  cmd = "PP",
  opts = {
    register = "+",
    provider = "dpaste.org",
    provider_options = {},
    notifier = vim.notify,
  },
}
