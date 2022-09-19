local status_ok, persistent_breakpoints = pcall(require, "persistent-breakpoints")
if not status_ok then
  return
end

persistent_breakpoints.setup({
  save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
  -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
  perf_record = false,
})
