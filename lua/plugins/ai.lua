return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    opts = {
      -- provider = "copilot",
      -- provider = "claude-code",
      provider = "deepseek",
      -- selection = {
      --   enabled = true,
      --   -- hint_display = "delayed",
      --   hint_display = "none",
      -- },
      -- behaviour = {
      --   auto_set_keymaps = false,
      -- },
      acp_providers = {
        ["claude-code"] = {
          command = "npx",
          args = { "@zed-industries/claude-code-acp" },
          env = {
            NODE_NO_WARNINGS = "1",
            ANTHROPIC_BASE_URL = os.getenv("ANTHROPIC_BASE_URL") or "https://api.anthropic.com",
            ANTHROPIC_AUTH_TOKEN = os.getenv("ANTHROPIC_AUTH_TOKEN"),
            ANTHROPIC_MODEL = os.getenv("ANTHROPIC_MODEL") or "claude-3-7-sonnet",
            ANTHROPIC_SMALL_FAST_MODEL = os.getenv("ANTHROPIC_SMALL_FAST_MODEL") or "claude-3-7-fast",
            CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = os.getenv("CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC") or "1",
          },
        },
      },
      shortcuts = {
        {
          name = "translator",
          description = "中英文翻译翻译专家",
          details = "帮助开发者进行中英文互译，确保翻译准确且符合技术文档风格。",
          prompt = "你是一位精通多种语言的软件开发领域翻译专家。你的任务是识别我提供的文本的语言，并准确地将其翻译成指定的目标语言, 如果我提供的中文，你翻译成英文，如果我提供的非中文，你翻译成中文，同时保留原文的含义、语气和细微差别。请在翻译版本中保持正确的语法、拼写和标点符号。",
        },
      },
      codebase = {
        enabled = true,
      },
      disabled_tools = {
        -- "list_files", -- Built-in file operations
        -- "search_files",
        -- "read_file",
        -- "create_file",
        -- "rename_file",
        -- "delete_file",
        -- "create_dir",
        -- "rename_dir",
        -- "delete_dir",
        -- "bash", -- Built-in terminal access
        "web_search",
      },
      providers = {
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-chat",
        },
        -- copilot = {
        --   endpoint = "https://api.githubcopilot.com",
        --   model = "claude-3.7-sonnet",
        --   proxy = nil, -- [protocol://]host[:port] Use this proxy
        --   allow_insecure = false, -- Allow insecure server connections
        --   timeout = 30000, -- Timeout in milliseconds
        --   extra_request_body = {
        --     max_tokens = 20480,
        --     temperature = 0,
        --   },
        -- },
      },
      -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub bef
      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        local hub_prompt = hub and hub:get_active_servers_prompt() or ""
        return hub_prompt .. "\n\n请使用中文回答所有问题。请用简体中文进行对话和回复。"
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
    },
  },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- Recommended/example keymaps.
      vim.keymap.set({ "n", "x" }, "<C-a>", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode" })

      vim.keymap.set({ "n", "x" }, "<C-x>", function()
        require("opencode").select()
      end, { desc = "Execute opencode action…" })

      vim.keymap.set({ "n", "i", "t" }, "<C-=>", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go", function()
        return require("opencode").operator("@this ")
      end, { expr = true, desc = "Add range to opencode" })

      vim.keymap.set("n", "goo", function()
        return require("opencode").operator("@this ") .. "_"
      end, { expr = true, desc = "Add line to opencode" })

      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "opencode half page up" })

      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "opencode half page down" })

      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
      vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
      vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
    end,
  },
  -- {
  --   "coder/claudecode.nvim",
  --   keys = {
  --     { "<C-=>", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code", mode = { "n", "x", "t" } },
  --   },
  --   opts = {
  --     auto_start = true,
  --     terminal_cmd = "/opt/homebrew/bin/claude", -- Use output from 'which claude'
  --     -- Diff Integration
  --     diff_opts = {
  --       auto_close_on_accept = true,
  --       vertical_split = true,
  --       open_in_current_tab = true,
  --       keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
  --     },
  --     terminal = {
  --       -- provider = "native",
  --       ---@module "snacks"
  --       ---@type snacks.win.Config|{}
  --       snacks_win_opts = {
  --         on_win = function(self)
  --           self:set_title("Claude Code", "center")
  --         end,
  --         position = "bottom",
  --         -- width = 0.9,
  --         -- height = 0.9,
  --         border = "rounded",
  --         keys = {
  --           claude_hide = {
  --             "<C-=>",
  --             function(self)
  --               self:hide()
  --             end,
  --             mode = "t",
  --             desc = "Hide",
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = true,
  -- },
}
