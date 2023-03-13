require("user.config")
require("lazy").setup("user.plugins")
-- init order above this line matters
pcall(require, "user.cmp")
pcall(require, "user.lsp")
pcall(require, "user.telescope")
pcall(require, "user.treesitter")
pcall(require, "user.project")
pcall(require, "user.dapconfig")
pcall(require, "user.dap-ui")
pcall(require, "user.persistent-breakpoints")
pcall(require, "user.messages")
pcall(require, "user.iron")
pcall(require, "user.noice")
pcall(require, "user.local")
pcall(require, "user.tint")
