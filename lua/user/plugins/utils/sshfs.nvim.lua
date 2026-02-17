---@type LazyPluginSpec
return {
  "uhs-robert/sshfs.nvim",
  cmd = {
    "SSHConnect",
    "SSHDisconnect",
    "SSHDisconnectAll",
    "SSHConfig",
    "SSHReload",
    "SSHFiles",
    "SSHGrep",
    "SSHLiveFind",
    "SSHLiveGrep",
    "SSHExplore",
    "SSHChangeDir",
    "SSHCommand",
    "SSHTerminal",
  },
  opts = {
    host_paths = {
      ["spikenology"] = {
        "/var/services/homes/oula",
      },
    },
    global_paths = {
      "~/gits",
      "~/.config",
    },
    keymaps = {},
  },
}
