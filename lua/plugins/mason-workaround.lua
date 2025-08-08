return {
  {
    "mason-org/mason.nvim",
    -- version = "^2.0.0",
    version = "^1.11.0",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "lua-language-server",
        "pyright",
        -- "typescript-language-server",
        "bash-language-server",
        "json-lsp",
        "yaml-language-server",
        "html-lsp",
        "css-lsp",
        "ast-grep",
        "dockerfile-language-server",
        -- "markdownlint",
        "prettier",
        -- "biome",
        "protols",

        -- "js-debug-adapter",

        "goimports",
        "gofumpt",
        "gomodifytags",
        "impl",
        "gopls",
        "delve",
      })

      opts.automatic_installation = true
    end,
  },
  { "mason-org/mason-lspconfig.nvim", version = "^1.11.0" },
}
