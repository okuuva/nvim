return {
  "windwp/nvim-spectre",
  keys = {
    {
      "<leader>sc",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Current Word",
    },
    {
      "<leader>sr",
      function()
        require("spectre").open()
      end,
      desc = "Search and Replace",
    },
  },
  config = true,
}
