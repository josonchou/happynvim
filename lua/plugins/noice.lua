return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      routes = {
        -- 忽略eslint配置文件异常的错误
        {
          filter = {
            find = "eslint:[%s]+-32603",
          },
          view = false,
          -- opts = { skip = true },
        },
        {
          filter = {
            find = "Format[%s]+request[%s]+failed",
          },
          view = "mini",
        },
        {
          filter = {
            find = "No[%s]+information[%s]+available",
          },
          view = false,
        },
        -- 隐藏 LSP 签名帮助的自动弹出
        {
          filter = {
            event = "lsp",
            kind = "signature_help",
          },
          opts = { skip = true },
        },
        -- 将 LSP 悬停文档转化为 分割窗口
        {
          filter = {
            event = "lsp",
            kind = "hover",
          },
          view = "split",
          opts = {
            zIndex = 45,
            relative = "win",
            enter = true,
          },
        },

        -- 示例2：将长消息（超过10行）重定向到分割窗口
        -- {
        --   filter = { min_height = 10 },
        --   view = "split", -- 改用分割窗口显示
        --   opts = {
        --     zIndex = 45,
        --     relative = "win",
        --     -- enter = true,
        --   },
        --   -- opts = { enter = true }, -- 自动聚焦
        -- },
      },
    },
  },
}
