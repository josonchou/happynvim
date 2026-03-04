return {
  "nvim-flutter/flutter-tools.nvim",
  -- 当 vim.g.vscode 为 true 时，cond 为 false，插件不加载
  cond = function()
    return not vim.g.vscode
  end,
  -- keys = {
  --   { "<leader>r", "<cmd> FlutterRun <CR>" },
  -- },
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = true,
  opts = {
    fvm = false,
    ui = {
      border = "rounded",
      notification_style = "plugin",
    },
    decorations = {
      statusline = {
        app_version = true,
        device = true,
      },
    },
    closing_tags = {
      highlight = "Comment",
      prefix = "//",
      enabled = true,
    },
    lsp = {
      color = { -- show the derived colours for dart variables
        enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
        background = true, -- highlight the background
        background_color = { r = 19, g = 17, b = 24 }, -- required, when background is transparent
        foreground = false, -- highlight the foreground
        virtual_text = true, -- show the highlight using virtual text
        virtual_text_str = "■", -- the virtual text character to highlight
      },
      settings = {
        showTodos = true,
        inlayHints = false,
        showInlayHints = false,
        updateImportsOnRename = true,
        completeFunctionCalls = false,
        -- analysisExcludedFolders = {
        --   vim.fn.expand("$HOME/.opt/flutter"),
        --   vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
        --   vim.fn.expand("$HOME/.pub-cache"),
        --   vim.fn.expand("$HOME/fvm"),
        --   vim.fn.expand(".dart_tool"),
        --   vim.fn.expand(".fvm"),
        --   vim.fn.expand("build"),
        --   vim.fn.expand("packages"),
        --   vim.fn.expand("ios"),
        --   vim.fn.expand("android"),
        --   vim.fn.expand("windows"),
        --   vim.fn.expand("linux"),
        --   vim.fn.expand("macos"),
        --   -- "**/.dart_tool/**",
        --   -- "**/.fvm/**",
        --   -- "**/build/**",
        --   -- "**/ios/**",
        --   -- "**/android/**",
        --   -- "**/windows/**",
        --   -- "**/linux/**",
        --   -- "**/macos/**",
        --   -- "**/.pub-cache/**",
        --   -- "**/AppData/Local/Pub/Cache/**",
        -- },
        enableSnippets = true,
      },
    },
    debugger = {
      enabled = true,
      run_via_dap = true,
      evaluate_to_string_in_debug_views = true,
      -- register_configurations = function(paths)
      --   -- require("dap").configurations.dart = {
      --   --   --put here config that you would find in .vscode/launch.json
      --   -- }
      --   -- If you want to load .vscode launch.json automatically run the following:
      --   require("dap.ext.vscode").load_launchjs(nil, { "dart" })
      -- end,
    },
    root_patterns = { ".git", "pubspec.yaml" },
    dev_tools = {
      autostart = true,
      auto_open_browser = false,
    },
    dev_log = {
      enabled = true,
      open_cmd = "tabedit", -- command to use to open the log buffer
    },
  },
}
