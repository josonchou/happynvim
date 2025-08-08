-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local map = vim.keymap.set

if vim.g.vscode then
  -- VSCode extension
  map("n", "<leader>cf", "<Cmd>lua require('vscode').call('editor.action.formatDocument')</CR>", { desc = "Format" })
  map("v", "<leader>cf", "<Cmd>lua require('vscode').call('editor.action.formatSelection')<CR>", { desc = "Format" })
  map("n", "<leader>cr", "<Cmd>lua require('vscode').call('editor.action.rename')<CR>", { desc = "Rename" })
  map(
    "n",
    "<leader>e",
    "<Cmd>lua require('vscode').call('workbench.view.explorer')<CR>",
    { desc = "Open File Explorer" }
  )
  -- map(
  --   "n",
  --   "<C-/>",
  --   "<Cmd>lua require('vscode').call('workbench.action.terminal.toggleTerminal')<CR>",
  --   { desc = "Toggle Termiinal" }
  -- )
  map(
    "n",
    "]e",
    "<Cmd>lua require('vscode').call('editor.action.marker.nextInFiles')<CR>",
    { desc = "Goto next error" }
  )
else
  -- ordinary Neovim
  -- require("catppuccin").load("macchiato")

  -- require("lspconfig").protols.setup({})
end
-- function Transparent(color)
--   color = color or "tokyonight"
--   vim.cmd.colorscheme(color)
--   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end
-- Transparent()
--
--
