vim.filetype.add({
  extension = {
    ["code-workspace"] = "json",
    hujson = "hujson",
    rockspec = "rockspec",
    xxhc = "yaml",
  },
})

vim.treesitter.language.register("jsonc", "hujson")
