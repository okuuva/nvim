-- Panel stacking per position.
-- When a panel appears, competing panels are hidden and pushed onto a stack.
-- Closing the visible panel restores the previous one from the stack.
local ft_to_group = {
  snacks_terminal = { pos = "bottom", index = 1 },
  trouble = { pos = "bottom", index = 2 },
  qf = { pos = "bottom", index = 2 },
  sidekick_terminal = { pos = "bottom", index = 3 },
  help = { pos = "right", index = 1 },
}

-- Build a reverse map: for each position, map group index → list of filetypes
local pos_groups = {}
for ft, mapping in pairs(ft_to_group) do
  local pos = mapping.pos
  pos_groups[pos] = pos_groups[pos] or {}
  pos_groups[pos][mapping.index] = pos_groups[pos][mapping.index] or {}
  table.insert(pos_groups[pos][mapping.index], ft)
end
-- Trouble symbols is dynamically resolved to right index 2 inside resolve_mapping,
-- but we need it in pos_groups so help (right index 1) knows to hide it
pos_groups["right"] = pos_groups["right"] or {}
pos_groups["right"][2] = { "trouble" }

-- Track active panel windows (win -> ft) to avoid re-triggering
-- on focus changes within existing panels
local active_panels = {}

-- Per-position panel stacks. Top of stack (last element) = currently visible.
-- Each entry: { group_key = "pos:index", ft = "filetype", bufnr = number }
local pos_stacks = { bottom = {}, right = {} }

-- Guard: set true during programmatic nvim_win_hide to prevent
-- WinClosed from interpreting it as a user close.
local is_hiding_programmatically = false

--- Resolve the effective mapping for a filetype+window,
--- handling the trouble symbols special case.
--- Returns nil for trouble when the window variable isn't set yet (caller should retry).
local function resolve_mapping(ft, win)
  local mapping = ft_to_group[ft]
  if not mapping then
    return nil
  end
  if ft == "trouble" and vim.api.nvim_win_is_valid(win) then
    local info = vim.w[win].trouble
    if not info then
      return nil -- not yet set; caller retries
    end
    if info.mode == "symbols" then
      return { pos = "right", index = 2 }
    end
  end
  return mapping
end

--- Build a restore closure for a stack entry.
local function make_restore(ft, mode)
  if ft == "snacks_terminal" then
    return function()
      Snacks.terminal.toggle()
    end
  elseif ft == "trouble" then
    return function()
      vim.cmd("Trouble " .. (mode or "diagnostics"))
    end
  elseif ft == "qf" then
    return function()
      vim.cmd("copen")
    end
  elseif ft == "sidekick_terminal" then
    return function()
      require("sidekick.cli").toggle()
    end
  elseif ft == "help" then
    return function()
      require("user.util.help_panel").toggle()
    end
  end
end

--- Hide all visible windows belonging to filetypes in the given groups,
--- except for `except_win`.
local function hide_competing_windows(pos, except_group, except_win)
  local groups = pos_groups[pos] or {}
  is_hiding_programmatically = true
  for idx, fts in pairs(groups) do
    if idx ~= except_group then
      for _, w in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(w) and w ~= except_win then
          local panel = active_panels[w]
          if panel and panel.pos == pos then
            local buf = vim.api.nvim_win_get_buf(w)
            if vim.tbl_contains(fts, vim.bo[buf].filetype) then
              pcall(vim.api.nvim_win_hide, w)
            end
          end
        end
      end
    end
  end
  is_hiding_programmatically = false
end

--- Restore the top of the stack for a position using native panel commands.
--- Skips entries without a restore function.
local function restore_top(pos)
  local stack = pos_stacks[pos]
  while #stack > 0 do
    local top = stack[#stack]
    if top.restore then
      vim.defer_fn(function()
        top.restore()
      end, 50)
      return
    end
    table.remove(stack)
  end
end

local function on_panel_visible(ft, win, retries)
  retries = retries or 0
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  if active_panels[win] then
    return
  end

  local mapping = resolve_mapping(ft, win)
  if not mapping then
    -- trouble window variable not yet set; retry up to 5 times
    if retries < 5 then
      vim.defer_fn(function()
        if vim.api.nvim_win_is_valid(win) then
          on_panel_visible(ft, win, retries + 1)
        end
      end, 50)
      return
    end
    -- Retries exhausted; fall back to default mapping
    mapping = ft_to_group[ft]
    if not mapping then
      return
    end
  end

  local pos = mapping.pos
  local group_key = pos .. ":" .. mapping.index

  active_panels[win] = { ft = ft, pos = pos }

  local stack = pos_stacks[pos]
  local bufnr = vim.api.nvim_win_get_buf(win)

  -- Get trouble mode for restore
  local mode
  if ft == "trouble" then
    local info = vim.w[win].trouble
    if info then
      mode = info.mode
    end
  end

  local entry = {
    group_key = group_key,
    ft = ft,
    bufnr = bufnr,
    restore = make_restore(ft, mode),
  }

  -- If same group as current top, replace in place (e.g. switching trouble modes)
  if #stack > 0 and stack[#stack].group_key == group_key then
    stack[#stack] = entry
    return
  end

  -- Dedup: remove any earlier entry with the same group_key
  for i = #stack, 1, -1 do
    if stack[i].group_key == group_key then
      table.remove(stack, i)
    end
  end

  -- Hide competing windows
  hide_competing_windows(pos, mapping.index, win)

  -- Push new entry
  table.insert(stack, entry)
end

--- Deferred wrapper that gives edgy time to process the window
--- into its views before we switch groups.
local function defer_panel_visible(ft, buf)
  vim.defer_fn(function()
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end
    local win = vim.fn.bufwinid(buf)
    if win ~= -1 then
      on_panel_visible(ft, win)
    end
  end, 50)
end

local au_group = vim.api.nvim_create_augroup("edgy_panel_exclusion", { clear = true })

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = au_group,
  callback = function(ev)
    local ft = vim.bo[ev.buf].filetype
    if ft_to_group[ft] then
      defer_panel_visible(ft, ev.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = au_group,
  callback = function(ev)
    if ft_to_group[ev.match] then
      defer_panel_visible(ev.match, ev.buf)
    end
  end,
})

vim.api.nvim_create_autocmd("WinClosed", {
  group = au_group,
  callback = function(ev)
    local win = tonumber(ev.match)
    if not win then
      return
    end

    local info = active_panels[win]
    active_panels[win] = nil

    if is_hiding_programmatically then
      return
    end

    if not info then
      return
    end

    local pos = info.pos
    local ft = info.ft
    local stack = pos_stacks[pos]
    if #stack == 0 then
      return
    end

    -- Only pop if the closed window's ft matches the stack top
    if stack[#stack].ft == ft then
      table.remove(stack)
      restore_top(pos)
    end
  end,
})

---@type LazyPluginSpec
return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  ---@module "edgy"
  ---@type Edgy.Config
  opts = {
    animate = {
      enabled = false,
      fps = 120,
    },
    bottom = {
      {
        ft = "snacks_terminal",
        title = "Terminal",
        size = { height = 0.4 },
        filter = function(buf)
          local info = vim.b[buf].snacks_terminal
          -- exclude fullscreen terminals (lazygit, jjui)
          return not (info and info.cmd)
        end,
      },
      {
        ft = "trouble",
        title = "Trouble",
        size = { height = 0.4 },
        filter = function(_, win)
          local info = vim.w[win].trouble
          return not info or info.mode ~= "symbols"
        end,
      },
      { ft = "qf", title = "QuickFix" },
      {
        ft = "sidekick_terminal",
        title = "Sidekick",
        size = { height = 0.4 },
      },
    },
    right = {
      {
        ft = "help",
        title = "Help",
        size = { width = 0.4 },
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
      {
        ft = "trouble",
        title = "Trouble Symbols",
        size = { width = 60 },
        filter = function(_, win)
          local info = vim.w[win].trouble
          return info and info.mode == "symbols"
        end,
      },
    },
    wo = {
      winbar = false,
    },
  },
}
