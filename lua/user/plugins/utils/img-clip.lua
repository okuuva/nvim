-- TODO: check telescope integration
-- https://github.com/HakonHarnes/img-clip.nvim?tab=readme-ov-file#telescopenvim
-- TODO: check oil integration
-- https://github.com/HakonHarnes/img-clip.nvim?tab=readme-ov-file#oilnvim

---@type LazyPluginSpec
return {
  "HakonHarnes/img-clip.nvim",
  keys = {
    { "<leader>i", "<cmd>PasteImage<cr>", desc = "Paste image" },
  },
  opts = {
    -- recommended settings
    default = {
      prompt_for_file_name = false,
      drag_and_drop = {
        insert_mode = true,
      },
    },
  },
}
