-- return {
--   {
--     "okuuva/auto-save.nvim",
--     version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
--     cmd = "ASToggle", -- optional for lazy loading on command
--     event = {
--       "BufEnter",
--       "InsertEnter",
--       -- "InsertLeave",
--       -- "TextChanged",
--     }, -- optional for lazy loading on trigger events
--     opts = {
--       enabled = false,
--       -- your config goes here
--       -- or just leave it empty :)
--       --
--       --
--       trigger_events = {
--         -- "FocusLost",
--         -- immediate_save = { "BufLeave", "FocusLost" }, -- 失焦时立即保存
--         -- debounce_delay = { "TextChanged", 1500 }, -- 输入停止1.5秒后保存
--       },
--
--       debounce_delay = 1500,
--     },
--     config = function(_, opts)
--       local cnf = require("auto-save.config")
--
--       cnf.opts.trigger_events = opts.trigger_events
--       require("auto-save").off()
--       require("auto-save").on()
--     end,
--   },
-- }
--

return {
  "Pocco81/auto-save.nvim",
  -- 当 vim.g.vscode 为 true 时，cond 为 false，插件不加载
  cond = function()
    return not vim.g.vscode
  end,
  lazy = false,
  opts = {
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")

      -- First check the default conditions
      if not (fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {})) then
        return false
      end

      -- Exclude claudecode diff buffers by buffer name patterns
      local bufname = vim.api.nvim_buf_get_name(buf)
      if bufname:match("%(proposed%)") or bufname:match("%(NEW FILE %- proposed%)") or bufname:match("%(New%)") then
        return false
      end

      -- Exclude by buffer variables (claudecode sets these)
      if
        vim.b[buf].claudecode_diff_tab_name
        or vim.b[buf].claudecode_diff_new_win
        or vim.b[buf].claudecode_diff_target_win
      then
        return false
      end

      -- Exclude by buffer type (claudecode diff buffers use "acwrite")
      local buftype = fn.getbufvar(buf, "&buftype")
      if buftype == "acwrite" then
        return false
      end

      return true -- Safe to auto-save
    end,
    -- enabled = true,
    trigger_events = {
      "BufLeave",
      "FocusLost",
    },
    debounce_delay = 1500,
    execution_message = {
      message = function()
        return "AutoSave: saved"
      end,
    },
  },
  -- keys = {
  --   { "<leader>uv", "<cmd>ASToggle<CR>", desc = "Toggle autosave" },
  -- },
  config = function(_, opts)
    local cnf = require("auto-save.config")

    cnf.opts.trigger_events = opts.trigger_events
    cnf.opts.condition = opts.condition
    require("auto-save").off()
    require("auto-save").on()
  end,
}
