return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    cond = function()
      return not vim.g.vscode
    end,
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
    "nickjvandyke/opencode.nvim",
    -- 当 vim.g.vscode 为 true 时，cond 为 false，插件不加载
    cond = function()
      return not vim.g.vscode
    end,
    -- cmd = { "OpenCode", "OpenCodeToggle", "OpenCodeContext" },
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    -- opts = {
    --   -- 窗口布局配置：设置为 vertical 才能被 edgy 捕获到侧边栏
    --   window = {
    --     layout = "vertical",
    --     position = "right",
    --     width = 0.4,
    --   },
    --   -- 自动滚动到最新对话
    --   auto_scroll = true,
    --   -- 事件配置：当 opencode 编辑文件后自动重载
    --   events = {
    --     reload = true,
    --   },
    --   -- 快捷 prompts 库
    --   prompts = {
    --     -- 诊断修复
    --     fix = {
    --       prompt = "Fix the following diagnostics: @diagnostics",
    --     },
    --     -- 代码审查
    --     review = {
    --       prompt = "Review the following code for correctness and readability: @this",
    --     },
    --     -- 解释代码
    --     explain = {
    --       prompt = "Explain what this code does and its context: @this",
    --     },
    --     -- 添加文档
    --     document = {
    --       prompt = "Add comments documenting this code: @this",
    --     },
    --     -- 实现功能
    --     implement = {
    --       prompt = "Implement the following requirement: @this",
    --     },
    --     -- 优化性能
    --     optimize = {
    --       prompt = "Optimize this code for performance and readability: @this",
    --     },
    --     -- 添加测试
    --     test = {
    --       prompt = "Add tests for this code: @this",
    --     },
    --   },
    -- },
    -- keys = {
    --   -- 切换主界面
    --   { "<C-=>", "<cmd>OpenCodeToggle<cr>", desc = "OpenCode AI" },
    --   -- 添加上下文（使用 Snacks Picker）
    --   { "<C-,>", "<cmd>OpenCodeContext<cr>", desc = "Add Context (Snacks Picker)" },
    -- },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        window = {
          layout = "vertical",
          position = "right",
          width = 0.4,
        },
        auto_scroll = true,
        events = {
          reload = true,
        },
        prompts = {
          fix = { prompt = "Fix the following diagnostics: @diagnostics" },
          review = { prompt = "Review the following code for correctness and readability: @this" },
          explain = { prompt = "Explain what this code does and its context: @this" },
          document = { prompt = "Add comments documenting this code: @this" },
          implement = { prompt = "Implement the following requirement: @this" },
          optimize = { prompt = "Optimize this code for performance and readability: @this" },
          test = { prompt = "Add tests for this code: @this" },
        },
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- 自定义快捷键映射
      local map = vim.keymap.set

      -- 1. 基础操作
      -- vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,
      map({ "n", "t", "i" }, "<C-=>", function()
        require("opencode").toggle()
      end, { desc = "Toggle Opencode" })

      map({ "n", "x" }, "<C-a>", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode about selection" })

      map({ "n", "x" }, "<C-x>", function()
        require("opencode").select()
      end, { desc = "Execute opencode action" })

      -- 2. Operator 模式 - 支持范围和 dot-repeat
      map({ "n", "x" }, "go", function()
        return require("opencode").operator("@this ")
      end, { expr = true, desc = "Add range to opencode" })

      map("n", "goo", function()
        return require("opencode").operator("@this ") .. "_"
      end, { expr = true, desc = "Add line to opencode" })

      -- 3. 滚动控制
      map("n", "<S-C-u>", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "Scroll opencode up" })

      map("n", "<S-C-d>", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Scroll opencode down" })

      map("n", "<leader>ot", function()
        require("opencode").toggle()
      end, { desc = "OpenCode: Toggle" })

      -- 4. 快速 prompts（使用 leader 前缀）
      map("n", "<leader>oxf", function()
        require("opencode").prompt("fix")
      end, { desc = "OpenCode: Fix diagnostics" })

      map("n", "<leader>oxr", function()
        require("opencode").prompt("review")
      end, { desc = "OpenCode: Review code" })

      map("n", "<leader>oxe", function()
        require("opencode").prompt("explain")
      end, { desc = "OpenCode: Explain code" })

      map("n", "<leader>oxd", function()
        require("opencode").prompt("document")
      end, { desc = "OpenCode: Document code" })

      map("n", "<leader>oxo", function()
        require("opencode").prompt("optimize")
      end, { desc = "OpenCode: Optimize code" })

      map("n", "<leader>oxt", function()
        require("opencode").prompt("test")
      end, { desc = "OpenCode: Add tests" })

      -- 5. 会话控制
      map("n", "<leader>oxn", function()
        require("opencode").command("session.new")
      end, { desc = "OpenCode: New session" })

      map("n", "<leader>oxs", function()
        require("opencode").command("session.select")
      end, { desc = "OpenCode: Select session" })

      map("n", "<leader>oxi", function()
        require("opencode").command("session.interrupt")
      end, { desc = "OpenCode: Interrupt" })

      -- 6. 替换默认的 + - 快捷键（因为 <C-a> 和 <C-x> 被占用）
      map("n", "+=", "<C-a>", { desc = "Increment under cursor", noremap = true })
      map("n", "+-", "<C-x>", { desc = "Decrement under cursor", noremap = true })

      -- 7. 事件处理 - 当 opencode 编辑文件后自动重载
      vim.api.nvim_create_autocmd("User", {
        pattern = "OpencodeEvent:*",
        callback = function(args)
          local event = args.data.event
          if event.type == "session.idle" then
            vim.notify("OpenCode finished responding", vim.log.levels.INFO)
          elseif event.type == "edit" then
            vim.notify("File edited by OpenCode", vim.log.levels.INFO)
          end
        end,
      })
    end,
  },
  -- {
  --   "nickjvandyke/opencode.nvim",
  --   version = "*", -- Latest stable release
  --   dependencies = {
  --     {
  --       -- `snacks.nvim` integration is recommended, but optional
  --       ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
  --       "folke/snacks.nvim",
  --       optional = true,
  --       opts = {
  --         input = {}, -- Enhances `ask()`
  --         picker = { -- Enhances `select()`
  --           actions = {
  --             opencode_send = function(...)
  --               return require("opencode").snacks_picker_send(...)
  --             end,
  --           },
  --           win = {
  --             input = {
  --               keys = {
  --                 ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
  --               },
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = function()
  --     ---@type opencode.Opts
  --     vim.g.opencode_opts = {
  --       -- Your configuration, if any; goto definition on the type or field for details
  --     }
  --
  --     vim.o.autoread = true -- Required for `opts.events.reload`
  --
  --     -- Recommended/example keymaps
  --     vim.keymap.set({ "n", "x" }, "<C-a>", function()
  --       require("opencode").ask("@this: ", { submit = true })
  --     end, { desc = "Ask opencode…" })
  --     vim.keymap.set({ "n", "x" }, "<C-x>", function()
  --       require("opencode").select()
  --     end, { desc = "Execute opencode action…" })
  --
  --     vim.keymap.set({ "n", "i", "t" }, "<C-=>", function()
  --       require("opencode").toggle()
  --     end, { desc = "Toggle opencode" })
  --
  --     vim.keymap.set({ "n", "x" }, "go", function()
  --       return require("opencode").operator("@this ")
  --     end, { desc = "Add range to opencode", expr = true })
  --     vim.keymap.set("n", "goo", function()
  --       return require("opencode").operator("@this ") .. "_"
  --     end, { desc = "Add line to opencode", expr = true })
  --
  --     vim.keymap.set("n", "<S-C-u>", function()
  --       require("opencode").command("session.half.page.up")
  --     end, { desc = "Scroll opencode up" })
  --     vim.keymap.set("n", "<S-C-d>", function()
  --       require("opencode").command("session.half.page.down")
  --     end, { desc = "Scroll opencode down" })
  --
  --     -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
  --     vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
  --     vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  --   end,
  -- },
  -- 增强 UI：让 OpenCode 像 IDE 侧边栏一样固定 (选配)
  {
    "folke/edgy.nvim",
    cond = function()
      return not vim.g.vscode
    end,
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "opencode",
        title = "OpenCode Agent",
        size = { width = 0.5 },
        pinned = true,
        wo = {
          winbar = false,
          number = false,
          relativenumber = false,
        },
      })
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
