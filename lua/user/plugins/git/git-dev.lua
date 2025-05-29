local function open_prompt()
  vim.ui.input({
    prompt = "Remote repo / url to open:",
  }, function(input)
    require("git-dev").open(input)
  end)
end

---@type LazyPluginSpec
return {
  "moyiz/git-dev.nvim",
  version = "v0.*",
  lazy = true,
  cmd = {
    "GitDevClean",
    "GitDevCleanAll",
    "GitDevCloseBuffers",
    "GitDevOpen",
    "GitDevRecents",
    "GitDevToggleUI",
    "GitDevXDGHandle",
  },
  -- stylua: ignore
  keys = {
    { "<leader>go", open_prompt, desc = "Open remote repo" },
    -- TODO: create snacks picker for this
    -- { "<leader>gR", "<cmd>GitDevRecents<cr>", desc = "Recent repos" },
  },
  opts = {
    ephemeral = false,
    cd_type = "tab",
    opener = function(dir, _, selected_path)
      vim.cmd("tabnew")
      vim.cmd("edit " .. dir)
      if selected_path then
        vim.cmd("edit " .. selected_path)
      end
    end,
    xdg_handler = {
      -- TODO: figure out how to make this work
      -- enabled = true,
    },
  },
}
