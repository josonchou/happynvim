-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.opt.expandtab = true -- 使用空格代替制表符
vim.opt.shiftwidth = 4 -- 每次缩进的空格数
vim.opt.tabstop = 4 -- Tab 显示为 4 个空格
vim.opt.softtabstop = 4 -- 按退格键时删除 4 个空格
vim.opt.smartindent = true -- 智能缩进
vim.opt.autoindent = true -- 自动继承上一行缩进

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "python", "typescript", "javascript", "javascriptreact", "typescriptreact", "dart" },
  callback = function()
    vim.opt_local.smartindent = true
    vim.opt_local.autoindent = true
    vim.opt_local.expandtab = true -- 使用空格代替制表符
    vim.opt_local.shiftwidth = 2 -- 每次缩进的空格数
    vim.opt_local.tabstop = 2 -- Tab 显示为 2 个空格
    vim.opt_local.softtabstop = 2 -- 按退格键时删除 2 个空格
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "less" },
  callback = function()
    vim.treesitter.language.register("css", "less")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  callback = function()
    vim.b.autoformat = false
    local map = vim.keymap.set

    map({ "n", "i", "t", "x", "v" }, "<D-F>", "<Cmd>TTSFixAndFormat<cr>", {
      noremap = true,
      silent = true,
      desc = "Format ts code and auto fix by eslint",
    })

    -- map({ "n", "i", "t", "x", "v" }, "<C-F>", "<Cmd>TTSFixAndFormat<cr>", {
    --   noremap = true,
    --   silent = true,
    --   desc = "Format ts code and auto fix by eslint",
    -- })
  end,
})

local guessDir = vim.fn.argv(0)

-- 检查目录是否合法，不合法则使用默认目录
local function is_valid_directory(path)
  return vim.fn.isdirectory(path) == 1
end

if not is_valid_directory(guessDir) then
  guessDir = vim.fn.expand("$HOME/Workspace/")
end

if vim.g.neovide then
  -- g:neovide_opacity should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_opacity = 0.8
  vim.g.neovide_normal_opacity = 0.8
  -- vim.g.neovide_background_color = "#0f1117" .. alpha()

  -- vim.g.neovide_title_background_color =
  -- string.format("%x", vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).bg)

  -- vim.g.neovide_title_text_color = "pink"

  vim.g.neovide_window_blurred = true

  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_macos_simple_fullscreen = true

  vim.defer_fn(function()
    vim.cmd("NeovideFocus")
  end, 25)
else
end

vim.api.nvim_create_autocmd("TabNew", {
  pattern = "*",
  callback = function(args)
    local file_path = args.file or args.match
    -- -- 获取当前标签页的窗口 ID
    -- local win_id = vim.api.nvim_tabpage_get_win(0)
    -- local buf_id = vim.api.nvim_win_get_buf(win_id)
    -- local file_path = vim.api.nvim_buf_get_name(buf_id)
    -- print(vim.inspect(args))
    --
    -- vim.notify("After TabNew" .. args.data.win_id)

    -- 检查路径是否为目录（如 ~/dir）
    if vim.fn.isdirectory(file_path) == 1 then
      vim.cmd("tcd " .. file_path) -- 切换到目标目录
    else
      vim.cmd("tcd " .. guessDir) -- 切换到目标目录
    end
  end,
})

vim.cmd("tcd " .. guessDir)
vim.notify("Hi, nvim is auto cd to " .. guessDir)

local random = math.random(1000, 9999)

vim.g.default_tab_id = vim.api.nvim_get_current_tabpage()
vim.g.matina_guess_dir = guessDir

vim.g.unique_instance_id = string.format("%d-%d", os.time(), random)
