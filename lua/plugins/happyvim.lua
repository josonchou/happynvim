return {
  {
    -- "ellisonleao/gruvbox.nvim",
    {
      "folke/tokyonight.nvim",
      opts = {
        style = "moon",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      },
    },
    {
      "LazyVim/LazyVim",
      opts = {
        -- colorscheme = "gruvbox",
        -- colorscheme = "catppuccin-mocha",
        -- colorscheme = "catppuccin",
        colorscheme = "tokyonight",
      },
    },
    -- change trouble config
    {
      "folke/trouble.nvim",
      -- opts will be merged with the parent spec
      opts = { use_diagnostic_signs = true },
    },

    {
      "folke/todo-comments.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      opts = {
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = {
            icon = " ",
            color = "info",
            alt = { "TODO", "todo", "Todo" },
          },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
          fg = "NONE",
          bg = "BOLD",
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        highlight = {
          multiline = true, -- enable multine todo comments
          multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
          multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
          before = "", -- "fg" or "bg" or empty
          keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
          after = "fg", -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:?]], -- pattern or table of patterns, used for highlighting (vim regex)
          -- pattern = [[.*<(KEYWORDS)\s*(:|\s)]], -- pattern or table of patterns, used for highlighting (vim regex)
          comments_only = true, -- uses treesitter to match keywords in comments only
          max_line_len = 400, -- ignore lines longer than this
          exclude = {}, -- list of file types to exclude highlighting
        },
        search = {
          -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          pattern = [[\b(KEYWORDS)(:|\s)]], -- match without the extra colon. You'll likely get false positives
        },
        -- keys = {
        --   {
        --     "<leader>st",
        --     function()
        --       Snacks.picker.todo_comments()
        --     end,
        --     desc = "Todo1",
        --   },
        --   {
        --     "<leader>sT",
        --     function()
        --       Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        --     end,
        --     desc = "Todo/Fix/Fixme",
        --   },
        -- },
      },
    },
    { import = "lazyvim.plugins.extras.lang.json" },
    {
      "neovim/nvim-lspconfig",
      ---@class PluginLspOpts
      opts = {
        -- make sure mason installs the server
        servers = {
          --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
          --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
          -- tsserver = {
          --   enabled = true,
          -- },
          -- ts_ls = {
          --   enabled = false,
          -- },
          eslint = {
            settings = {
              workingDirectory = { mode = "auto" },
              -- validate = {
              --   "javascript",
              --   "javascriptreact",
              --   "typescriptreact",
              --   "typescript",
              -- },
            },
            -- on_attach = function(client, bufnr)
            --   -- vim.api.nvim_create_autocmd("BufWritePre", {
            --   --   buffer = bufnr,
            --   --   command = "EslintFixAll",
            --   -- })
            -- end,
            -- format = false,
            -- autoFixOnSave = {
            --   enable = true,
            -- },
            -- format = {
            --   enable = false,
            -- },
            -- codeActionOnSave = {
            --   enable = true,
            -- },
          },
          volar = {
            init_options = {
              vue = {
                hybridMode = true,
              },
            },
          },
          cssls = {
            filetypes = {
              "css",
              "less",
              "scss",
            },
            settings = {
              css = {
                validate = true,
              },
              less = {
                validate = true,
              },
              scss = {
                validate = true,
              },
            },
          },
          gopls = {
            settings = {
              gopls = {
                ui = {
                  completion = {
                    usePlaceholders = false,
                  },
                },
                gofumpt = true,
                codelenses = {
                  gc_details = false,
                  generate = true,
                  regenerate_cgo = true,
                  run_govulncheck = true,
                  test = true,
                  tidy = true,
                  upgrade_dependency = true,
                  vendor = true,
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
                analyses = {
                  nilness = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                usePlaceholders = false,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                semanticTokens = true,
              },
            },
          },
        },
        setup = {
          eslint = function()
            require("lazyvim.util").lsp.on_attach(function(client)
              if client.name == "eslint" then
                client.server_capabilities.documentFormattingProvider = true
              elseif client.name == "tsserver" then
                client.server_capabilities.documentFormattingProvider = false
              end
            end)
          end,
          --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
          --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
          -- tsserver = function()
          --   -- disable tsserver
          --   return true
          -- end,
          -- ts_ls = function()
          --   -- disable tsserver
          --   return true
          -- end,
          -- vtsls = function(_, opts)
          --   LazyVim.lsp.on_attach(function(client, buffer)
          --     client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
          --       ---@type string, string, lsp.Range
          --       local action, uri, range = unpack(command.arguments)
          --
          --       local function move(newf)
          --         client.request("workspace/executeCommand", {
          --           command = command.command,
          --           arguments = { action, uri, range, newf },
          --         })
          --       end
          --
          --       local fname = vim.uri_to_fname(uri)
          --       client.request("workspace/executeCommand", {
          --         command = "typescript.tsserverRequest",
          --         arguments = {
          --           "getMoveToRefactoringFileSuggestions",
          --           {
          --             file = fname,
          --             startLine = range.start.line + 1,
          --             startOffset = range.start.character + 1,
          --             endLine = range["end"].line + 1,
          --             endOffset = range["end"].character + 1,
          --           },
          --         },
          --       }, function(_, result)
          --         ---@type string[]
          --         local files = result.body.files
          --         table.insert(files, 1, "Enter new path...")
          --         vim.ui.select(files, {
          --           prompt = "Select move destination:",
          --           format_item = function(f)
          --             return vim.fn.fnamemodify(f, ":~:.")
          --           end,
          --         }, function(f)
          --           if f and f:find("^Enter new path") then
          --             vim.ui.input({
          --               prompt = "Enter move destination:",
          --               default = vim.fn.fnamemodify(fname, ":h") .. "/",
          --               completion = "file",
          --             }, function(newf)
          --               return newf and move(newf)
          --             end)
          --           elseif f then
          --             move(f)
          --           end
          --         end)
          --       end)
          --     end
          --   end, "vtsls")
          --   -- copy typescript settings to javascript
          --   opts.settings.javascript =
          --     vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
          -- end,
          gopls = function(_, opts)
            -- workaround for gopls not supporting semanticTokensProvider
            -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
            LazyVim.lsp.on_attach(function(client, _)
              if not client.server_capabilities.semanticTokensProvider then
                local semantic = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end, "gopls")
            -- end workaround
          end,
        },
      },
    },

    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {
          "bash",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
          "css",
          "vue",
          "go",
          "scss",
          "css",
          "gomod",
          "gowork",
          "gosum",
        })
      end,
    },
  },
}
