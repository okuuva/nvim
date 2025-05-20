--Toggle narrow zen mode for the open buffer
_G.toggle_narrow_zen = function()
  Snacks.zen({ win = { style = "narrow_zen" } })
end

---@type LazyPluginSpec
return {
  "snacks.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>zm", function() Snacks.zen() end,  desc = "Toggle Zen Mode" },
    { "<leader>zn", toggle_narrow_zen,            desc = "Toggle Zen Mode (Narrow)" },
  },
  ---@type snacks.Config
  opts = {
    zen = {
      -- see https://github.com/b0o/incline.nvim/discussions/77 for enabling incline for zen mode window
      -- callback where you can add custom code when the Zen window opens
      on_open = function()
        local status_ok, incline = pcall(require, "incline")
        if status_ok then
          incline.disable()
        end
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
        local status_ok, incline = pcall(require, "incline")
        if status_ok then
          incline.enable()
        end
      end,
    },
    styles = {
      zen = {
        backdrop = {
          transparent = false,
          win = {
            -- TODO: find out why the backdrop group is named SnacksBackdrop_<color code> by default
            wo = { winhighlight = "Normal:SnacksBackdrop" },
          },
        },
      },
      narrow_zen = {
        style = "zen",
        width = 80,
      },
    },
  },
}
