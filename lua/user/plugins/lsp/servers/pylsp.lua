-- Check https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md for instructions
return {
  settings = {
    pylsp = {
      configurationSources = {
        "flake8",
      },
      plugins = {
        -- jedi, the least sucky lsp for python
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
        -- rope, refactoring library
        rope_completion = {
          enabled = false,
          eager = false,
        },
        -- preload, for caching modules ahead of time
        preload = {
          enabled = true,
          modules = {},
        },
        -- ruff, one stop shop for your linting needs
        ruff = { enabled = true },
        -- explicitly disable all the other linters
        autopep8 = { enabled = false },
        flake8 = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = { enabled = false },
        pydocstyle = { enabled = false },
        pyflakes = { enabled = false },
        pylint = { enabled = false },
        yapf = { enabled = false },
      },
      rope = {
        extensionModules = nil,
        ropeFolder = nil,
      },
    },
  },
}
