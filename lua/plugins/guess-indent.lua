return {
  {
    "nmac427/guess-indent.nvim",
    -- 当 vim.g.vscode 为 true 时，cond 为 false，插件不加载
    cond = function()
      return not vim.g.vscode
    end,
    -- opts = {
    --   setup = {
    --     auto_cmd = true,
    --     override_editorconfig = true,
    --   },
    -- },
    config = function()
      require("guess-indent").setup({
        auto_cmd = true,
        override_editorconfig = true,
        filetype_exclude = {
          -- "typescript",
        },
        buftype_exclude = {
          "help",
          "nofile",
          "terminal",
          "prompt",
        },
      })
    end,
  },
}
