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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "python", "typescript", "javascript", "dart" },
  callback = function()
    vim.opt_local.expandtab = true -- 使用空格代替制表符
    vim.opt_local.shiftwidth = 2 -- 每次缩进的空格数
    vim.opt_local.tabstop = 2 -- Tab 显示为 2 个空格
    vim.opt_local.softtabstop = 2 -- 按退格键时删除 2 个空格
  end,
})

-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
end

vim.g.transparency = 0.8

if vim.g.neovide then
  -- g:neovide_opacity should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_opacity = 0.8
  vim.g.neovide_normal_opacity = 0.8
  vim.g.transparency = 0.9
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
end
