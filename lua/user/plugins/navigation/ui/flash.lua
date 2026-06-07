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

local function set_render_markdown_win_options(bufnr, config, state)
  for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
    if vim.api.nvim_win_is_valid(win) then
      for name, value in pairs(config.win_options) do
        vim.api.nvim_set_option_value(name, value[state], { win = win })
      end
    end
  end
end

local function pause_render_markdown()
  local render_markdown = package.loaded["render-markdown"]
  if not render_markdown or not render_markdown.get() then
    return nil
  end

  local manager_ok, manager = pcall(require, "render-markdown.core.manager")
  local state_ok, state = pcall(require, "render-markdown.state")
  if not manager_ok or not state_ok then
    return nil
  end

  local ui_ok, ui = pcall(require, "render-markdown.core.ui")
  if not ui_ok then
    return nil
  end

  local buffers = {}
  local seen = {}

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local bufnr = vim.api.nvim_win_get_buf(win)
    if not seen[bufnr] and manager.attached(bufnr) then
      seen[bufnr] = true
      local config = state.get(bufnr)
      if config.enabled then
        buffers[bufnr] = config
        config.enabled = false
        for _, extmark in ipairs(ui.get(bufnr):get()) do
          extmark:hide(ui.ns, bufnr)
        end
        set_render_markdown_win_options(bufnr, config, "default")
      end
    end
  end

  return next(buffers) and buffers or nil
end

local function resume_render_markdown(buffers)
  if not buffers then
    return
  end

  local ui_ok, ui = pcall(require, "render-markdown.core.ui")
  if not ui_ok then
    return
  end

  for bufnr, config in pairs(buffers) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      config.enabled = true
      for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
        ui.update(bufnr, win, "FlashResume", false)
      end
    end
  end
end

local function with_render_markdown_disabled(fn)
  return function()
    local paused = pause_render_markdown()
    local ok, err = xpcall(fn, debug.traceback)
    resume_render_markdown(paused)

    if not ok then
      error(err, 0)
    end
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
    -- home locations first, preferring index finger
    -- avoid qvxj since I find them hardest to reach
    labels = "hateniscrkmgpzfbloduwyvqxj",
  },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, with_render_markdown_disabled(regular_binding), desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, with_render_markdown_disabled(treesitter_binding), desc = "Flash Treesitter" },
    { "r", mode = "o", with_render_markdown_disabled(function() require("flash").remote() end), desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, with_render_markdown_disabled(function() require("flash").treesitter_search() end), desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
