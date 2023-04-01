local check_forbidden_patterns = function()
  local success, forbidden_patters = pcall(require, "user.config.local.codeium")
  forbidden_patters = success and forbidden_patters or {}
  local Util = require("user.util")
  local path = Util.get_root()
  for _, pattern in ipairs(forbidden_patters) do
    if path:find(pattern) then
      return false
    end
  end
  return true
end

return {
  "jcdickinson/codeium.nvim",
  event = "VeryLazy",
  cmd = "Codeium",
  cond = not vim.g.alpine_linux and check_forbidden_patterns(),
  dependencies = { "nvim-cmp" },
  config = true,
}
