-- TODO: check oil integration
-- https://github.com/HakonHarnes/img-clip.nvim?tab=readme-ov-file#oilnvim

-- check if the current file is in obsidian notes dir
local function notes_dir_path()
  return vim.fn.finddir("notes", vim.fn.expand("%") .. ";")
end

---@type LazyPluginSpec
return {
  "HakonHarnes/img-clip.nvim",
  keys = {
    { "<leader>i", "<cmd>PasteImage<cr>", desc = "Paste image" },
  },
  opts = {
    -- recommended settings
    default = {
      dir_path = function()
        -- assets/imgs is the default for obsidian.nvim, using it here for consistency
        return "assets/imgs/" .. vim.fn.expand("%:t:r")
      end,
      prompt_for_file_name = false,
      drag_and_drop = {
        insert_mode = true,
      },
    },
    custom = {
      {
        trigger = function()
          -- in obsidian notes
          return notes_dir_path() ~= ""
        end,
        dir_path = function()
          return notes_dir_path() .. "/../assets/imgs/" .. vim.fn.expand("%:t:r")
        end,
      },
    },
  },
}
