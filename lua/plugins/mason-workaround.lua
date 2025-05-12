return {
    {
        "mason-org/mason.nvim",
        version = "^1.11.0",
        opts = {
            ensure_installed = {
                "stylua",
                "shellcheck",
                "shfmt",
                "flake8",
                "lua-language-server",
                "pyright",
                "gopls",
                "goimports",
                "gofumpt",
                "typescript-language-server",
                "bash-language-server",
                "json-lsp",
                "yaml-language-server",
                "html-lsp",
                "css-lsp",
                "ast-grep",
                "dockerfile-language-server",
                -- "markdownlint",
                "prettier",
            },
            automatic_installation = true,
            -- ensure_installed = {
            --     "stylua",
            --     "shellcheck",
            --     "shfmt",
            --     "flake8",
            -- },
        }
    },
    { "mason-org/mason-lspconfig.nvim", version = "^1.11.0" },
}