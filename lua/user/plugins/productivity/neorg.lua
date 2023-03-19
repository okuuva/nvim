return {
  {
    "nvim-orgmode/orgmode",
    ft = "org",
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    build = ":Neorg sync-parsers",
    opts = function()
      local success, opts = pcall(require, "user.config.local.neorg")
      opts = success and opts or {}
      local workspaces = vim.tbl_deep_extend("force", {
        default = "~/neorg/personal", -- Format: <name_of_workspace> = <path_to_workspace_root>
      }, opts["workspaces"] or {})

      return {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.norg.dirman"] = {
            config = {
              workspaces = workspaces,
              index = "index.norg", -- The name of the main (root) .norg file
            },
          },
        },
      }
    end,
  },
}
