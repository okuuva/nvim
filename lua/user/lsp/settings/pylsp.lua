-- Check https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md for instructions
return {
  settings = {
    pylsp = {
      configurationSources = {
        "pycodestyle",
      },
      plugins = {
        autopep8 = {
          enabled = true,
        },
        flake8 = {
          config = nil,
          enabled = false,
          exclude = {},
          executable = "flake8",
          filename = nil,
          hangClosing = nil,
          ignore = {},
          indentSize = nil,
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
          enabled = true,
          threshold = 15,
        },
        preload = {
          enabled = true,
          modules = {},
        },
        pycodestyle = {
          exabled = true,
          exclude = {},
          filename = {},
          select = {},
          ignore = { "E501" },
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
        pyflakes = { enabled = true },
        pylint = {
          enabled = false,
          args = {},
          executable = nil,
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
