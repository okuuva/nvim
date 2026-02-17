-- lua/util/host.lua
local M = {}

local function hostname()
  -- $HOSTNAME is often set; fall back to `hostname` command.
  local env = vim.env.HOSTNAME
  if env and env ~= "" then
    return env
  end

  -- get hostname using uv if available
  local ok, h = pcall(vim.uv.os_gethostname)
  if ok and type(h) == "string" and h ~= "" then
    return h
  end

  -- fallback (in case of edge builds / weird env)
  local out = vim.fn.systemlist("hostname")
  return (out[1] or ""):gsub("%s+$", "")
end

function M.name()
  return hostname():lower()
end

function M.is(host)
  return M.name() == host
end

function M.matches(pattern)
  return M.name():match(pattern) ~= nil
end

return M
