require("user.config")
require("lazy").setup("user.plugins")
-- init order above this line matters
pcall(require, "user.git")
pcall(require, "user.cmp")
pcall(require, "user.lsp")
pcall(require, "user.telescope")
pcall(require, "user.treesitter")
pcall(require, "user.project")
pcall(require, "user.auto-save")
pcall(require, "user.whichkey")
pcall(require, "user.filetype")
pcall(require, "user.dapconfig")
pcall(require, "user.dap-ui")
pcall(require, "user.registers")
pcall(require, "user.fold-preview")
pcall(require, "user.statuscol")
pcall(require, "user.nvim-ufo")
pcall(require, "user.persistent-breakpoints")
pcall(require, "user.trouble")
pcall(require, "user.leap")
pcall(require, "user.window-picker")
pcall(require, "user.todo-comments")
pcall(require, "user.neoscroll")
pcall(require, "user.dressing")
pcall(require, "user.notify")
pcall(require, "user.messages")
pcall(require, "user.paperplanes")
pcall(require, "user.highlight-colors")
pcall(require, "user.toggleterm")
pcall(require, "user.iron")
pcall(require, "user.noice")
pcall(require, "user.smartcolumn")
pcall(require, "user.local")
pcall(require, "user.tint")
