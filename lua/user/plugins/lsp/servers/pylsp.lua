-- local pylint_path = function ()
--   local path = vim.env.VIRTUAL_ENV .. "/bin/pylint"
--   if vim.fn.executable(path) then
--     return path
--   end

-- Check https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md for instructions
return {
  settings = {
    pylsp = {
      configurationSources = {
        "flake8",
      },
      plugins = {
        autopep8 = {
          enabled = true,
        },
        flake8 = {
          config = nil,
          enabled = true,
          exclude = {},
          executable = "flake8",
          filename = nil,
          hangClosing = nil,
          ignore = { "E501", "W503" },
          indentSize = nil,
          maxLineLength = nil,
          perFileIgnores = {},
          select = nil,
        },
        jedi = {
          extra_paths = {},
          env_vars = nil,
          environment = nil,
        },
        jedi_completion = {
          enabled = true,
          include_params = true,
          include_class_objects = true,
          include_function_objects = true,
          fuzzy = true,
          eager = true,
          resolve_at_most = 25,
          cache_for = {
            "pandas",
            "numpy",
            "tensorflow",
            "matplotlib",
          },
        },
        jedi_definition = {
          enabled = true,
          follow_imports = true,
          follow_builtin_imports = true,
        },
        jedi_hover = { enabled = true },
        jedi_references = { enabled = true },
        jedi_signature_help = { enabled = true },
        jedi_symbols = {
          enabled = true,
          all_scopes = true,
          include_import_symbols = true,
        },
        mccabe = {
          enabled = false,
          threshold = 15,
        },
        preload = {
          enabled = true,
          modules = {},
        },
        pycodestyle = {
          enabled = false,
          exclude = {},
          filename = {},
          select = {},
          ignore = {},
          hangClosing = nil,
          maxLineLength = nil,
          indentSize = nil,
        },
        pydocstyle = {
          enabled = false,
          convention = nil,
          addIgnore = {},
          addSelect = {},
          ignore = {},
          select = {},
          match = "(?!test_).*\\.py",
          mathDir = "[^\\.].*",
        },
        pyflakes = { enabled = false },
        pylint = {
          enabled = false,
          args = {"--disable=line-too-long,unused-import"},
          -- executable = pylint_path(),
        },
        rope_completion = {
          enabled = false,
          eager = false,
        },
        yapf = { enabled = true },
      },
      rope = {
        extensionModules = nil,
        ropeFolder = nil,
      },
    },
  },
}
