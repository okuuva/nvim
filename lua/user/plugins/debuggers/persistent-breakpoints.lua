return {
  "Weissle/persistent-breakpoints.nvim",
  name = "persistent-breakpoints",
  opts = {
    save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
    -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
    perf_record = false,
  },
}
