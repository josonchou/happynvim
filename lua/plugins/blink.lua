return {
  { "Kaiser-Yang/blink-cmp-avante" },
  -- { "hrsh7th/cmp-emoji", lazy = true },
  -- { "hrsh7th/cmp-nvim-lsp", lazy = true },
  {
    "saghen/blink.cmp",
    opts = {
      snippets = {
        preset = "luasnip",
      },
      completion = {
        ghost_text = {
          enabled = false,
        },
        trigger = {
          show_on_blocked_trigger_characters = { " ", "\n", "\t", "!" },
        },
      },
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        -- compat = {
        --   enabled = true, -- 启用兼容模式
        --   sources = { -- 要桥接的 source 列表
        --     { name = "emoji" }, -- 必须与插件注册的 name 一致
        --   },
        -- },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        default = { "avante", "lsp", "path", "buffer", "snippets", "copilot" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
          },
          -- add any custom sources here
          -- will be loaded in the order they are defined
          -- if you want to override a source, set it to nil
          -- or set it to a function that returns nil
          -- for example:
          -- ["my_source"] = function() return nil end
          --
          copilot = {
            name = "copilot",
            kind = "Copilot",
            score_offset = -100,
            async = true,
          },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
        },
      },
      keymap = {
        preset = "super-tab",
        ["<c-y>"] = { "select_and_accept" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<c-x>"] = { "show", "show_documentation", "hide_documentation" },
      },
    },
  },
}
