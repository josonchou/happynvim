return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    opts = {
      on_attach = function(client, bufnr)
        -- 自定义按键映射或 LSP 附加逻辑（可选）
        vim.keymap.set("n", "<leader>cR", "<cmd>TSToolsRenameFile<cr>", { buffer = bufnr, desc = "Rename TS File" })
        vim.keymap.set(
          "n",
          "<leader>gD",
          "<cmd>TSToolsGoToSourceDefinition<cr>",
          { buffer = bufnr, desc = "Goto Source Definition" }
        )
        vim.keymap.set(
          "n",
          "<leader>gR",
          "<cmd>TSToolsFileReferences<cr>",
          { buffer = bufnr, desc = "File References" }
        )

        -- client.server_capabilities.documentFormattingProvider = false -- 禁用插件格式化

        vim.api.nvim_create_user_command("TTSFixAndFormat", function()
          LazyVim.format({ force = true })
          vim.cmd("TSToolsFixAll")
          vim.cmd("EslintFixAll") -- 再执行 ESLint 修复
        end, {})

        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --   callback = function()
        --     vim.cmd("TTSFixAndFormat")
        --   end,
        -- })

        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --   buffer = bufnr,
        --   command = "TTSFixAndFormat",
        -- })
      end,
      handlers = {
        -- ["textDocument/diagnostic"] = vim.api.filter_diagnostics(
        --   -- Ignore 'This may be converted to an async function' diagnostics.
        --   { -32603 }
        -- ),
        -- ["textDocument/publishDiagnostics"] = api.filter_diagnostics(
        --   -- Ignore 'This may be converted to an async function' diagnostics.
        --   { 80006 }
        -- ),
      },
      settings = {
        -- spawn additional tsserver instance to calculate diagnostics on it
        separate_diagnostic_server = true,
        -- "change"|"insert_leave" determine when the client asks the server about diagnostic
        publish_diagnostic_on = "insert_leave",
        -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
        -- "remove_unused_imports"|"organize_imports") -- or string "all"
        -- to include all supported code actions
        -- specify commands exposed as code_actions
        expose_as_code_action = {
          "fix_all",
          "add_missing_imports",
          "remove_unused",
          "remove_unused_imports",
          "organize_imports",
        },
        -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
        -- not exists then standard path resolution strategy is applied
        tsserver_path = "/Users/joson/Library/Application Support/fnm/node-versions/v22.18.0/installation/lib/node_modules/typescript/bin",
        -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
        -- (see 💅 `styled-components` support section)
        tsserver_plugins = {
          "@typescript-eslint/eslint-plugin",
          -- for TypeScript v4.9+
          -- "@styled/typescript-styled-plugin",
          -- or for older TypeScript versions
          -- "typescript-styled-plugin",
        },
        -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
        -- memory limit in megabytes or "auto"(basically no limit)
        tsserver_max_memory = "auto",
        -- described below
        -- tsserver_format_options = {},
        -- tsserver_file_preferences = {},
        -- locale of all tsserver messages, supported locales you can find here:
        -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
        tsserver_locale = "en",
        -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
        complete_function_calls = false,
        include_completions_with_insert_text = true,
        -- CodeLens
        -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
        -- possible values: ("off"|"all"|"implementations_only"|"references_only")
        code_lens = "off",
        -- by default code lenses are displayed on all referencable values and for some of you it can
        -- be too much this option reduce count of them by removing member references from lenses
        disable_member_code_lens = true,
        -- JSXCloseTag
        -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
        -- that maybe have a conflict if enable this feature. )
        jsx_close_tag = {
          enable = false,
          filetypes = { "javascriptreact", "typescriptreact" },
        },
      },
    },
  },
}
