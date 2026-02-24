-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.g.lazyvim_picker = "fzf"

vim.g.ai_cmp = true

-- vim.opt.fileformats = "unix,dos,mac"
vim.opt.fileformat = "unix"
vim.opt.fileformats = { "unix", "dos", "mac" }
-- vim.g.lazyvim_blink_main = true

vim.g.neovide_input_macos_option_key_is_meta = "only_left"
vim.g.mcphub_auto_approve = true
vim.g.lazyvim_prettier_needs_config = false
vim.g.lazyvim_eslint_auto_format = true

vim.opt.laststatus = 3

vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }

if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.08
  vim.g.neovide_cursor_trail_length = 0.5
  vim.g.neovide_cursor_antialiasing = true
  -- vim.g.neovide_refresh_rate = 144  -- 按你的显示器刷新率
  vim.g.neovide_no_idle = true
  vim.g.neovide_fullscreen = false
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_scroll_animation_length = 0.15

  vim.g.neovide_padding_top = 20
  -- g:neovide_opacity should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_theme = "auto"
  vim.g.neovide_opacity = 0.95
  vim.g.neovide_normal_opacity = 0.8
  vim.g.neovide_window_blurred = true

  -- vim.g.neovide_floating_shadow = true
  -- vim.g.neovide_floating_z_height = 10
  -- vim.g.neovide_light_angle_degrees = 45
  -- vim.g.neovide_light_radius = 5
else
end

vim.opt.title = true
vim.opt.titlestring = "SuperCoder: %{getcwd()}"

vim.opt.fixendofline = true

-- function _G.statusLine()
--   return vim.g.flutter_tools_decorations.device
-- end
--
-- vim.opt.statusline = "%!v:statusLine()"
--
