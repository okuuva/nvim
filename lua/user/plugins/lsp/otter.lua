vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "toml", "markdown", "tex" },
  group = vim.api.nvim_create_augroup("Otter", {}),
  callback = function()
    local ok, otter = pcall(require, "otter")
    if ok then
      otter.activate()
    end
  end,
})

return {
  "jmbuhr/otter.nvim",
  version = "^2.0.0",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    {
      "folke/which-key.nvim",
      optional = true,
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>loa", "<cmd>OtterActivate<cr>", desc = "Activate Otter" },
    { "<leader>lod", "<cmd>OtterDeactivate<cr>", desc = "Deactivate Otter" },
  },
  init = function()
    require("user.util").wk_add({
      { "<leader>l", group = "LSP" },
      { "<leader>lo", group = "Otter" },
    })
  end,
  opts = {
    buffers = {
      write_to_disk = false,
      ignore_pattern = {
        -- ipython cell magic (lines starting with %) and shell commands (lines starting with !)
        python = "^(%s*[%%!].*)",
      },
    },
  },
}
