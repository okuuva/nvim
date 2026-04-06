-- Mutually exclusive panel groups per position.
-- When a panel with a watched filetype appears, competing panels
-- in the same position are hidden via nvim_win_hide.
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
-- Trouble symbols is dynamically resolved to right index 2 inside on_panel_visible,
-- but we need it in pos_groups so help (right index 1) knows to hide it
pos_groups["right"] = pos_groups["right"] or {}
pos_groups["right"][2] = { "trouble" }

-- Track active panel windows (win -> ft) to avoid re-triggering
-- on focus changes within existing panels
local active_panels = {}

local function on_panel_visible(ft, win)
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  if active_panels[win] == ft then
    return
  end
  active_panels[win] = ft

  local mapping = ft_to_group[ft]
  if not mapping then
    return
  end

  -- For trouble, check if it's the symbols mode (right panel) or regular (bottom)
  if ft == "trouble" then
    local info = vim.w[win].trouble
    if info and info.mode == "symbols" then
      mapping = { pos = "right", index = 2 }
    end
  end

  -- Hide competing panel windows directly
  local groups = pos_groups[mapping.pos] or {}
  for idx, fts in pairs(groups) do
    if idx ~= mapping.index then
      for _, w in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(w) and w ~= win then
          local buf = vim.api.nvim_win_get_buf(w)
          if vim.tbl_contains(fts, vim.bo[buf].filetype) then
            pcall(vim.api.nvim_win_hide, w)
          end
        end
      end
    end
  end
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
    if win then
      active_panels[win] = nil
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
