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

map("i", "<M-j>", "<Down>", { desc = "Down" })
map("i", "<M-k>", "<Up>", { desc = "Up" })
map("i", "<M-h>", "<Left>", { desc = "Left" })
map("i", "<M-l>", "<Right>", { desc = "Right" })

map("i", "<M-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease Window Width" })
map("i", "<M-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase Window Width" })
map("i", "<M-Up>", "<Cmd>resize +2<CR>", { desc = "Increase Window Height" })
map("i", "<M-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease Window Height" })

if vim.g.vscode then
  -- VSCode extension
  map("n", "<leader>cf", "<Cmd>lua require('vscode').call('editor.action.formatDocument')<CR>", { desc = "Format" })
  map("v", "<leader>cf", "<Cmd>lua require('vscode').call('editor.action.formatSelection')<CR>", { desc = "Format" })
  map("n", "<leader>cr", "<Cmd>lua require('vscode').call('editor.action.rename')<CR>", { desc = "Rename" })
  map(
    "n",
    "<leader>e",
    "<Cmd>lua require('vscode').call('workbench.view.explorer')<CR>",
    { desc = "Open File Explorer" }
  )
  map(
    "n",
    "<C-/>",
    "<Cmd>lua require('vscode').call('workbench.action.terminal.toggleTerminal')<CR>",
    { desc = "Toggle Termiinal" }
  )
  map(
    "n",
    "]e",
    "<Cmd>lua require('vscode').call('editor.action.marker.nextInFiles')<CR>",
    { desc = "Goto next error" }
  )
  map(
    "n",
    "[e",
    "<Cmd>lua require('vscode').call('editor.action.marker.prevInFiles')<CR>",
    { desc = "Goto next error" }
  )
  map(
    "n",
    "]w",
    "<Cmd>lua require('vscode').call('editor.action.marker.nextInFiles')<CR>",
    { desc = "Goto next error" }
  )
  map(
    "n",
    "[w",
    "<Cmd>lua require('vscode').call('editor.action.marker.prevInFiles')<CR>",
    { desc = "Goto next error" }
  )
  map(
    "i",
    "<M-Right>",
    "<Cmd>lua require('vscode').call('workbench.action.increaseViewWidth')<CR>",
    { desc = "Increase vscode view width" }
  )
  map(
    "i",
    "<M-Left>",
    "<Cmd>lua require('vscode').call('workbench.action.decreaseViewWidth')<CR>",
    { desc = "Increase vscode view width" }
  )
  map(
    "i",
    "<M-Up>",
    "<Cmd>lua require('vscode').call('workbench.action.increaseViewSize')<CR>",
    { desc = "Increase vscode view width" }
  )
  map(
    "i",
    "<M-Down>",
    "<Cmd>lua require('vscode').call('workbench.action.decreaseViewSize')<CR>",
    { desc = "Increase vscode view width" }
  )
else
end

-- map("t", "vv", "<Esc>", { desc = "quick escape in terminal" })
-- map("i", "<C-j>", "<Down>", { desc = "插入模式下移动" })
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
