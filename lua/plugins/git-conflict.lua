return {
  "akinsho/git-conflict.nvim",
  -- 当 vim.g.vscode 为 true 时，cond 为 false，插件不加载
  cond = function()
    return not vim.g.vscode
  end,
  lazy = false,
  opts = {
    -- default_mappings = {
    --   ours = "o",
    --   theirs = "t",
    --   none = "<leader>h0",
    --   both = "<leader>hb",
    --   next = "]x",
    --   prev = "[x",
    -- },
  },
  keys = {
    {
      "<leader>gx",
      "<cmd>GitConflictListQf<cr>",
      desc = "List Conflicts",
    },
    {
      "<leader>gr",
      "<cmd>GitConflictRefresh<cr>",
      desc = "Refresh Conflicts",
    },
  },
}
