return {
  {
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
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>vd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>vh", "<cmd>DiffviewFileHistory %", desc = "Diffview Current File History" },
      { "<leader>vH", "<cmd>DiffviewFileHistory", desc = "Diffview Branch History" },
    },
    opts = {
      enhanced_diff_hl = true, -- 更好的高亮
      view = {
        merge_tool = {
          layout = "diff3_mixed", -- 合并时的布局风格
        },
      },
    },
  },
}
