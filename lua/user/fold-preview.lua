local status_ok, fold_preview = pcall(require, "fold-preview")
if not status_ok then
  return
end

fold_preview.setup({
  default_keybindings = true,
  border = "rounded", -- "none" | "single" | "double" | "rounded" | "solid" | "shadow" | string[] default: { ' ', '', ' ', ' ', ' ', ' ', ' ', ' ' }
})

