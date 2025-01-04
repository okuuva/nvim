return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  -- stylua: ignore
  keys = {
    { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Append", },
    { "<leader>hp", function() require("harpoon"):list():prepend() end, desc = "Prepend", },
    { "<leader>hl", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "List", },
    -- Dvorak
    { "<C-h>", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1", },
    { "<C-t>", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2", },
    { "<C-n>", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3", },
    { "<C-s>", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4", },
    -- Qwerty
    { "<C-j>", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1", },
    { "<C-k>", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2", },
    { "<C-l>", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3", },
    { "<C-;>", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4", },
  },
  dependencies = { "plenary.nvim" },
  config = function()
    require("harpoon"):setup()
  end,
}
