local augment_enabled = true

local function disable_augment(manual)
  local log_level = manual == true and vim.log.levels.INFO or vim.log.levels.DEBUG
  vim.notify("Augment disabled", log_level, { title = "Augment" })
  if manual == true then
    augment_enabled = false
  end

  -- a hack to clear the suggestion. augment doesn't expose a public API for it but this does the trick
  if vim.fn.exists("*augment#OnInsertLeavePre") == 1 then
    vim.fn["augment#OnInsertLeavePre"]()
  end
  vim.g.augment_disable_completions = true
end

local function enable_augment(manual)
  local log_level = manual == true and vim.log.levels.INFO or vim.log.levels.DEBUG
  vim.notify("Augment enabled", log_level, { title = "Augment" })
  if manual == true then
    augment_enabled = true
  end
  vim.g.augment_disable_completions = false
end

local disabled_filetypes = {
  "markdown",
  "gitcommit",
  "jjdescription",
}

vim.api.nvim_create_autocmd("User", {
  pattern = "DirChangedPre",
  callback = function(args)
    if args.match == "global" and package.loaded["augment"] then
      -- Reload the plugin to pick up the new workspace folder
      -- This is a bit hacky, but augment.vim doesn't provide a better way to do this
      require("lazy").reload({ plugins = { "augment.vim" } })
    end
  end,
  desc = "Set augment_workspace_folders to current directory on global cwd change",
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = disable_augment,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = enable_augment,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.list_contains(disabled_filetypes, vim.bo.filetype) then
      disable_augment()
    elseif augment_enabled then
      enable_augment()
    end
  end,
})

---@type LazyPluginSpec
return {
  "augmentcode/augment.vim",
  version = "*",
  cmd = { "Augment" },
  event = "VeryLazy",
  dependencies = {
    {
      "folke/which-key.nvim",
      optional = true,
    },
  },
  cond = require("user.util").ai_helpers_allowed("augment/augment.vim"),
  keys = {
    { "<leader>AA", "<cmd>Augment chat<cr>", desc = "Chat" },
    { "<leader>AN", "<cmd>Augment chat-new<cr> | <cmd>Augment chat<cr>", desc = "New chat" },
    { "<leader>AO", "<cmd>Augment chat-toggle<cr>", desc = "Toggle" },
  },
  init = function()
    vim.g.augment_workspace_folders = { vim.fn.getcwd() }
    vim.g.augment_disable_tab_mapping = true
    vim.g.augment_disable_completions = not augment_enabled
    require("user.util").wk_add({
      { "<leader>A", group = "Augment" },
    })
  end,
}
