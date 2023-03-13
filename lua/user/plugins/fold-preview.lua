return {
  "anuvyklack/fold-preview.nvim",
  dependencies = { "anuvyklack/keymap-amend.nvim" },
  opts = {
    auto = false, -- Automatically open preview if cursor enters and stays in folded line for specified number of milliseconds (400 is decent value).
    default_keybindings = true,
    border = "rounded", -- "none" | "single" | "double" | "rounded" | "solid" | "shadow" | string[] default: { ' ', '', ' ', ' ', ' ', ' ', ' ', ' ' }
  },
}
