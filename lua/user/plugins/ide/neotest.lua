local function _focus(winid)
  local win = vim.fn.bufwinid(winid)
  if win > -1 then
    vim.api.nvim_set_current_win(win)
  end
end

local function focus_output()
  _focus("Neotest Output Panel")
end

local function toggle_output()
  require("neotest").output_panel.toggle()
  focus_output()
end

local function focus_summary()
  _focus("Neotest Summary")
end

local function toggle_summary()
  require("neotest").summary.toggle()
  focus_summary()
end

local function open_summary()
  require("neotest").summary.open()
  focus_summary()
end

local function unless_active(fn)
  local ft = vim.api.nvim_get_option_value("filetype", {})
  if ft:find("neotest-") then
    return
  end
  fn()
end

local function run(...)
  require("neotest").run.run(...)
  unless_active(open_summary)
end

---@type LazyPluginSpec
return {
  "nvim-neotest/neotest",
  -- version = "^4.1.3",
  -- stylua: ignore
  keys = {
    -- run
    { "<leader>td", function() run(vim.fn.expand('%:h')) end, desc = "Run in current dir" },
    { "<leader>tn", function() run() end, desc = "Run nearest test" },
    { "<leader>tf", function() run(vim.fn.expand('%')) end, desc = "Run current file" },
    { "<leader>tp", function() run(vim.fn.getcwd()) end, desc = "Run tests for the whole project" },
    -- toggle
    { "<leader>tto", toggle_output, desc = "Output panel" },
    { "<leader>tts", toggle_summary, desc = "Summary" },
  },
  dependencies = {
    -- common dependencies
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- adapters
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-plenary",
  },
  init = function()
    -- see https://github.com/nvim-neotest/neotest-go/blob/f2580cad67ef0181403cf65858ab638ffd3ede9f/README.md?plain=1#L16-42
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)
    require("user.util").wk_add({
      { "<leader>tt", group = "Toggle" },
    })
  end,
  config = function()
    local neotest = require("neotest")
    neotest.setup({
      adapters = {
        require("neotest-go"),
        require("neotest-plenary"),
      },
      quickfix = {
        enabled = true,
        open = true,
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = true,
      },
    })
  end,
}
