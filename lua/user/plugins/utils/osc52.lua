local function copy()
  if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
    require("osc52").copy_register("+")
  end
end

return {
  "ojroques/nvim-osc52",
  event = "VeryLazy",
  init = function()
    vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
  end,
  -- stylua: ignore
  opts = {
    max_length = 0,      -- Maximum length of selection (0 for no limit)
    silent     = false,  -- Disable message on successful copy
    trim       = false,  -- Trim surrounding whitespaces before copy
  },
}
