vim.filetype.add({
  extension = {
    xxhc = "yaml",
    ["code-workspace"] = "json",
    hujson = "hujson",
  },
})

vim.treesitter.language.register("jsonc", "hujson")
