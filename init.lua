require("user.config")
require("lazy").setup("user.plugins")
-- init order above this line matters
pcall(require, "user.lsp")
pcall(require, "user.treesitter")
pcall(require, "user.local")
