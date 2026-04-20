-- Clipboard configuration:
-- Remote (SSH): force OSC52 so the clipboard lands on the *local* machine
-- instead of the remote X/Wayland display.
-- Local: let Neovim autodetect (pbcopy/wl-copy/xclip/xsel) — native IO avoids
-- the OSC52 paste query, which hangs when the terminal (e.g. cmux) doesn't
-- answer the read.
local function file_exists(path)
  return (vim.uv.fs_stat(path) or {}).type ~= nil
end

local function in_container()
  if file_exists("/.dockerenv") or file_exists("/run/.containerenv") then
    return true
  end
  local f = io.open("/proc/1/cgroup", "r")
  if f then
    local data = f:read("*a") or ""
    f:close()
    if data:find("docker") or data:find("kubepods") or data:find("containerd") or data:find("lxc") then
      return true
    end
  end
  return false
end

local function is_remote_session()
  -- Explicit override — set NVIM_REMOTE=1 in remote shell rc when heuristics miss
  -- (e.g. mosh reattach, nested shells that dropped SSH_*).
  if vim.env.NVIM_REMOTE == "1" then
    return true
  end
  if vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil or vim.env.SSH_CLIENT ~= nil then
    return true
  end
  -- Mosh inherits SSH_* on initial fork but some setups export MOSH_CONNECTION.
  if vim.env.MOSH_CONNECTION ~= nil or vim.env.MOSH_SERVER ~= nil then
    return true
  end
  if in_container() then
    return true
  end
  return false
end

local function has_native_clipboard()
  if vim.fn.has("mac") == 1 and vim.fn.executable("pbcopy") == 1 then
    return true
  end
  if vim.fn.executable("wl-copy") == 1 or vim.fn.executable("xclip") == 1 or vim.fn.executable("xsel") == 1 then
    return true
  end
  return false
end

local function sync_tmux_clipboard()
  if vim.env.TMUX ~= nil then
    vim.fn.system({ "tmux", "refresh-client", "-l" })
    vim.uv.sleep(10)
  end
end

local function get_osc52_clipboard()
  local osc52 = require("vim.ui.clipboard.osc52")
  return {
    name = "OSC 52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = function()
        sync_tmux_clipboard()
        return osc52.paste("+")()
      end,
      ["*"] = function()
        sync_tmux_clipboard()
        return osc52.paste("*")()
      end,
    },
  }
end

if is_remote_session() or not has_native_clipboard() then
  vim.g.clipboard = get_osc52_clipboard()
end

return {
  "gbprod/yanky.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  keys = {
    { "y", "<Plug>(YankyYank)", desc = "Yank text", mode = { "n", "x" } },
    { "p", "<Plug>(YankyPutAfter)", desc = "Put after cursor", mode = { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", desc = "Put before cursor", mode = { "n", "x" } },
    { "gp", "<Plug>(YankyGPutAfter)", desc = "Put after selection", mode = { "n", "x" } },
    { "gP", "<Plug>(YankyGPutBefore)", desc = "Put before selection", mode = { "n", "x" } },
    { "]P", "<Plug>(YankyPutIndentAfter)", desc = "Put indented after cursor", mode = { "n", "x" } },
    { "[P", "<Plug>(YankyPutIndentBefore)", desc = "Put indented before cursor", mode = { "n", "x" } },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
    { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
    { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
  },
  opts = {
    ring = {
      history_length = 100,
      storage = "sqlite",
      sync_with_numbered_registers = true,
      cancel_event = "update",
    },
    picker = {
      select = {
        action = nil, -- nil to use default put action
      },
    },
    system_clipboard = {
      sync_with_ring = true,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 500,
    },
    preserve_cursor_position = {
      enabled = true,
    },
  },
}
