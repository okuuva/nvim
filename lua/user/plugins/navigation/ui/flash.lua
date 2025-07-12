local eol_jumper_opts = {
  search = {
    ---@param str string
    mode = function(str)
      if str:find("^  $") then
        -- match only EOL if pattern is exactly two spaces
        return "$"
      elseif str:find("^   +$") then
        -- match n-1 spaces if pattern is 3 or more spaces
        -- so 3 spaces matches 2, 7 matches 6 etc.
        return str:sub(1, -2)
      end
      return str
    end,
  },
}

local function regular_binding()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].filetype ~= "mcphub" then
    require("flash").jump(eol_jumper_opts)
  end
end

local function treesitter_binding()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].filetype == "mcphub" then
    require("flash").jump(eol_jumper_opts)
  else
    require("flash").treesitter()
  end
end

---@type LazyPluginSpec
return {
  "folke/flash.nvim",
  version = "^2.1.0",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    -- use enthium layout as a base
    -- home row, bottom row, top row
    -- home locations first, preferring inside rolls
    -- avoid qzxj since I find them hardest to reach
    labels = "cieasnthrbvkfpgmyouwdlqzxj",
  },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, regular_binding, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, treesitter_binding, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
