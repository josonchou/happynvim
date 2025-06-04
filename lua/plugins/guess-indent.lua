return {
  {
    "nmac427/guess-indent.nvim",
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
