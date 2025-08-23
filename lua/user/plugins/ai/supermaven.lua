-- copied from https://github.com/supermaven-inc/supermaven-nvim/issues/61#issuecomment-2221680509
local pending_oneshot = false

--- Enable / Disable / One-shots inline completion
---
--- @param oneshot? boolean Optional oneshot parameter.
local function toggle_inline_completion(oneshot)
  local suggestion = require("supermaven-nvim.completion_preview")
  local binary = require("supermaven-nvim.binary.binary_handler")
  local preview = require("supermaven-nvim.completion_preview")
  local message = "Inline AI autocompletion "

  local log_level = oneshot and vim.log.levels.DEBUG or vim.log.levels.INFO

  -- If inline completion is already on, we don't one-shot
  if oneshot and not suggestion.disable_inline_completion then
    return
  end

  if suggestion.disable_inline_completion then
    suggestion.disable_inline_completion = false
    vim.notify(message .. "ENABLED", log_level, { title = "SuperMaven" })

    local buffer = vim.api.nvim_get_current_buf()
    local file_name = vim.api.nvim_buf_get_name(buffer)

    binary:on_update(buffer, file_name, "cursor")
    binary:poll_once()

    if oneshot then
      pending_oneshot = true
    end
  else
    suggestion.disable_inline_completion = true
    vim.notify(message .. "DISABLED", log_level, { title = "SuperMaven" })

    preview:dispose_inlay()

    pending_oneshot = false
  end
end

--- Potentially clears one-shot if one is pending
local function clear_oneshot()
  if pending_oneshot then
    local suggestion = require("supermaven-nvim.completion_preview")
    local preview = require("supermaven-nvim.completion_preview")

    pending_oneshot = false
    suggestion.disable_inline_completion = true
    preview:dispose_inlay()
  end
end

---@type LazyPluginSpec
return {
  "supermaven-inc/supermaven-nvim",
  cond = require("user.util").ai_helpers_allowed("supermaven-nvim"),
  event = "VeryLazy",
  dependencies = {
    {
      "folke/which-key.nvim",
      optional = true,
    },
  },
  keys = {
    {
      "<C-space>",
      function()
        toggle_inline_completion(true)
      end,
      desc = "One-shot Supermaven inline completion",
      remap = true,
      mode = "i",
    },
    { "<leader>ass", "<cmd>SupermavenStart<cr>", desc = "Start Supermaven" },
    { "<leader>asS", "<cmd>SupermavenStop<cr>", desc = "Stop Supermaven" },
    { "<leader>asr", "<cmd>SupermavenRestart<cr>", desc = "Restart Supermaven" },
    { "<leader>ast", toggle_inline_completion, desc = "Toggle Supermaven" },
  },
  opts = {
    disable_inline_completion = true, -- disables inline completion for use with cmp
    disable_keymaps = true, -- disables built in keymaps for more manual control
  },
  init = function()
    local ok, wk = pcall(require, "which-key")
    if not ok then
      return
    end
    wk.add({
      { "<leader>as", group = "Supermaven" },
    })
  end,
  config = function(_, opts)
    require("supermaven-nvim").setup(opts)

    local suggestion = require("supermaven-nvim.completion_preview")

    local old_accept = suggestion.on_accept_suggestion

    -- Override the accept suggeston command to turn off one-shot
    ---@diagnostic disable-next-line: duplicate-set-field
    suggestion.on_accept_suggestion = function()
      old_accept()

      if pending_oneshot then
        suggestion.disable_inline_completion = true
        pending_oneshot = false
      end
    end

    -- Get the Supermaven autocmd group
    local augroup = vim.api.nvim_create_augroup("supermaven", { clear = false })

    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
      group = augroup,
      callback = clear_oneshot,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = augroup,
      callback = clear_oneshot,
    })

    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
      group = augroup,
      callback = clear_oneshot,
    })
  end,
}
