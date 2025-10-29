local function resolve_conflicts()
  local result = vim.system({ "jj" }):wait()
  if result.code == 0 then
    return vim.cmd("JJDiffConflicts")
  end
  return vim.cmd("DiffConflicts")
end

---@type LazyPluginSpec[]
return {
  {
    "whiteinge/diffconflicts",
    cmd = { "DiffConflicts" },
    keys = {
      { "<leader>gR", resolve_conflicts, desc = "Resolve conflicts" },
      -- { "<leader>jc" },
    },
  },
  {
    "rafikdraoui/jj-diffconflicts",
    cmd = { "JJDiffConflicts" },
    keys = {
      { "<leader>jc", resolve_conflicts, desc = "Conflict resolution" },
    },
  },
}
