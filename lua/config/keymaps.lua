-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--#region
--

local map = vim.keymap.set

-- map("n", "<leader>B", function()
--   Snacks.terminal(nil, { cwd = LazyVim.root() })
-- end, { desc = "which_key_ignore" })

-- map("t", "<leader>B", "<cmd>close<cr>", { desc = "which_key_ignore" })

map("i", "jj", "<Esc>", { desc = "quick escape" })
-- map("t", "vv", "<Esc>", { desc = "quick escape in terminal" })
-- map("i", "<C-j>", "<Down>", { desc = "插入模式下移动" })
-- map("i", "<D-k>", "<Up>", { desc = "插入模式上移动" })
-- map("i", "<D-h>", "<Left>", { desc = "To Left" })
-- map("i", "<D-l>", "<Right>", { desc = "To Right" })

-- map("i", "vv", function()
--   require("cmp").abort()
-- end, { desc = "取消联想" })

-- map("i", "??", function()
--   require("cmp").open_docs()
-- end, { desc = "查看文档" })

-- map("n", "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "Inline assistant" })
-- map("n", "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle a chat buffer", noremap = true, silent = true })
-- map("n", "<leader>ak", "<cmd>CodeCompanionCmd<cr>", { desc = "Open the Action Palette" })
-- map("n", "<leader>ac", "<cmd>CodeCompanionActions<cr>", { desc = "Open the Action Palette", noremap = true, silent = true })
