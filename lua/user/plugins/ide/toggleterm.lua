return {
  "akinsho/toggleterm.nvim",
  version = "^2.4.0",
  cmd = "ToggleTerm",
  event = "VeryLazy",
  keys = {
    { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazygit" },
  },
  init = function()
    function _G.set_terminal_keymaps()
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
  config = function()
    require("toggleterm").setup({
      env = { GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=delete'" },
      size = 20,
      open_mapping = [[<c-t>]],
      hide_numbers = false,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = "/usr/bin/env fish",
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "tab",
      on_close = function ()
        require("neo-tree.events").fire_event("git_event")
      end,
    })

    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    local node = Terminal:new({ cmd = "node", hidden = true })

    function _NODE_TOGGLE()
      node:toggle()
    end

    local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

    function _NCDU_TOGGLE()
      ncdu:toggle()
    end

    local htop = Terminal:new({ cmd = "sudo -H htop", hidden = true })

    function _HTOP_TOGGLE()
      htop:toggle()
    end

    local python = Terminal:new({ cmd = "python", hidden = true })

    function _PYTHON_TOGGLE()
      python:toggle()
    end
  end,
}
