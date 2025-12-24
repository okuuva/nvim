vim.filetype.add({
  extension = {
    ["code-workspace"] = "json",
    hujson = "hujson",
    mdtext = "markdown",
    mdtxt = "markdown",
    mdwn = "markdown",
    rmd = "markdown", -- I doubt I ever run into R Markdown but if I do, I'll figure what I actually want then
    rockspec = "rockspec",
    xxhc = "yaml",
  },
})

vim.treesitter.language.register("jsonc", "hujson")
