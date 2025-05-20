--- Get an icon from `mini.icons` or `nvim-web-devicons`.
--- Modified from the [original](https://github.com/folke/snacks.nvim/blob/bc0630e43be5699bb94dadc302c0d21615421d93/lua/snacks/util/init.lua#L125)
--- to prefer nvim-web-devicons over mini.icons
---
---@param name string
---@param cat? string defaults to "file"
---@param opts? { fallback?: {dir?:string, file?:string} }
---@return string, string?
local function prefer_web_devicons(name, cat, opts)
  opts = opts or {}
  opts.fallback = opts.fallback or {}
  local try = {
    function()
      if cat == "directory" then
        return opts.fallback.dir or "󰉋 ", "Directory"
      end
      local Icons = require("nvim-web-devicons")
      if cat == "filetype" then
        return Icons.get_icon_by_filetype(name, { default = false })
      elseif cat == "file" then
        local ext = name:match("%.(%w+)$")
        return Icons.get_icon(name, ext, { default = false }) --[[@as string, string]]
      elseif cat == "extension" then
        return Icons.get_icon(nil, name, { default = false }) --[[@as string, string]]
      end
    end,
    function()
      return require("mini.icons").get(cat or "file", name)
    end,
  }
  for _, fn in ipairs(try) do
    local ret = { pcall(fn) }
    if ret[1] and ret[2] then
      return ret[2], ret[3]
    end
  end
  return opts.fallback.file or "󰈔 "
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(event)
    if event.data == "snacks.nvim" then
      Snacks.util.icon = prefer_web_devicons
      return true
    end
  end,
})
