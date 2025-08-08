return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- lsp_keymaps = false,
      -- other options
      lsp_cfg = false,
    },
    config = function(lp, opts)
      require("go").setup(opts)
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  -- {
  --   "fang2hou/go-impl.nvim",
  --   ft = "go",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --
  --     -- Choose one of the following fuzzy finder
  --     -- "folke/snacks.nvim",
  --     "ibhagwan/fzf-lua",
  --   },
  --   opts = {},
  --   keys = {
  --     {
  --       "<leader>cI",
  --       function()
  --         require("go-impl").open()
  --       end,
  --       mode = { "n" },
  --       desc = "Go Impl",
  --     },
  --   },
  -- },
  -- {
  --   "venomlab/goimpl.nvim",
  --   tag = "0.1.0",
  --   config = function()
  --     local goimpl = require("goimpl")
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = { "golang", "go" },
  --       callback = function()
  --         vim.keymap.set("n", "<leader>cI", function()
  --           if goimpl.is_go() then
  --             goimpl.impl()
  --           end
  --         end, {
  --           desc = "实现接口",
  --         })
  --       end,
  --     })
  --   end,
  -- },
}
