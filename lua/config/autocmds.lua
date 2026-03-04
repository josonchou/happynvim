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

    map({ "n", "i", "t", "x", "v" }, "<M-F>", function()
      LazyVim.format({ force = true })
      LazyVim.lsp.action["source.fixAll.ts"]()
      -- 检查 EslintFixAll 命令是否存在
      -- if vim.fn.exists(":EslintFixAll") > 0 then
      --   vim.cmd("EslintFixAll") -- 再执行 ESLint 修复
      -- end

      vim.defer_fn(function()
        if vim.fn.exists(":EslintFixAll") > 0 then
          vim.cmd("EslintFixAll") -- 再执行 ESLint 修复
        end
      end, 300)
    end, {
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

local function createMatinaApi()
  _G.matinaCodeState = {
    superCodeId = "",
    defaultTabId = "",
    rootDir = "",
    counter = 0,
    terms = {},
  }

  local state = _G.matinaCodeState

  local matinaApi = {}

  function matinaApi:getState()
    return state
  end

  function matinaApi:isValidDirectory(path)
    return vim.fn.isdirectory(path) == 1
  end

  function matinaApi:getTermArgs()
    local tabId = "term"
    local guessDir = state.rootDir
    local id = state.superCodeId or state.rootDir or "$HOME/Workspace/"

    local isDir = vim.fn.isdirectory(guessDir) == 1
    if not isDir then
      guessDir = vim.fn.expand("$HOME/Workspace/")
    end

    return guessDir, id, tabId
  end

  function matinaApi:init()
    state.rootDir = vim.fn.argv(0)
    -- 检查目录是否合法，不合法则使用默认目录
    if not self:isValidDirectory(state.rootDir) then
      state.rootDir = vim.fn.expand("$HOME/Workspace/")
    end
    local random = math.random(1000, 9999)
    state.defaultTabId = vim.api.nvim_get_current_tabpage()
    state.superCodeId = string.format("%d-%d", os.time(), random)
  end

  function matinaApi:setRootDir(path)
    if not self:isValidDirectory(path) then
      state.rootDir = vim.fn.expand("$HOME/Workspace/")
    else
      state.rootDir = path
    end
  end

  function matinaApi:termLen()
    local len = 0
    for _ in pairs(state.terms) do
      len = len + 1
    end
    return len
  end

  function matinaApi:hideAllTerm()
    for _, termArgs in pairs(state.terms) do
      local term = Snacks.terminal.get(termArgs.cmd or nil, termArgs.opts)
      if term ~= nil then
        term:hide()
      end
    end
  end

  function matinaApi:toggleTerminal(id, cmd)
    local dir, uniqueId, tabId = self:getTermArgs()
    local terms = state.terms
    local size = self:termLen()
    local termId = string.format("%s-%s-%s", tabId, id, uniqueId)

    if terms[termId] ~= nil then
      local currTerm = terms[termId]
      Snacks.terminal(currTerm.cmd or nil, currTerm.opts)
      return
    end

    local termArgs = {
      cmd = cmd or nil,
      opts = {
        cwd = dir,
        count = size + 1,
        win = {
          border = "double",
        },
        env = {
          nvim_instance_id = uniqueId,
          nvim_term_id = termId,
        },
      },
    }

    terms[termId] = termArgs
    Snacks.terminal(termArgs.cmd or nil, termArgs.opts)
  end

  matinaApi:init()
  vim.g.matinaApi = matinaApi

  return matinaApi, state
end

local matinaApi, matinaState = createMatinaApi()
local is_dart_project_cached = nil

if vim.g.vscode then
else
  vim.cmd("cd " .. matinaState.rootDir)
  -- 缓存 Dart 项目检测结果

  local function check_dart_project()
    -- 向上递归查找 pubspec.yaml（从当前目录到根目录）
    local path = vim.fn.getcwd()
    while true do
      -- 使用 glob 检查当前目录
      local pubspec = vim.fn.glob(path .. "/pubspec.yaml")
      if pubspec ~= "" then
        return true
      end
      -- 获取父目录
      local parent = vim.fn.fnamemodify(path, ":h")
      if parent == path then
        break
      end
      path = parent
    end
    return false
  end

  local function is_dart_project()
    return is_dart_project_cached
  end

  -- Create an autocommand group
  vim.api.nvim_create_augroup("MatinaApi", { clear = true })

  -- VimEnter 时预检查并缓存结果
  -- vim.api.nvim_create_autocmd("VimEnter", {
  --   group = "FlutterAutoQuit",
  --   callback = function()
  --     is_dart_project_cached = check_dart_project()
  --   end,
  -- })

  -- 退出时直接使用缓存结果
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = "MatinaApi",
    callback = function()
      if is_dart_project() then
        vim.cmd("FlutterQuit")
      end
    end,
    desc = "Automatically run FlutterQuit when exiting Neovim in a Dart project",
  })

  vim.api.nvim_create_autocmd("DirChanged", {
    group = "MatinaApi",
    pattern = "*",
    callback = function(args)
      local scope = args.match
      local new_dir = vim.fn.getcwd()
      vim.notify("SuperCoder is cd to :" .. scope .. "->" .. new_dir)
      if scope == "global" then
        matinaApi:setRootDir(new_dir)
      end
      is_dart_project_cached = check_dart_project()
    end,
  })

  -- vim.api.nvim_create_autocmd("TabNew", {
  --   pattern = "*",
  --   callback = function(args)
  --     local file_path = args.file or args.match
  --     -- -- 获取当前标签页的窗口 ID
  --     -- local win_id = vim.api.nvim_tabpage_get_win(0)
  --     -- local buf_id = vim.api.nvim_win_get_buf(win_id)
  --     -- local file_path = vim.api.nvim_buf_get_name(buf_id)
  --     -- print(vim.inspect(args))
  --     --
  --     -- vim.notify("After TabNew" .. args.data.win_id)
  --
  --     -- 检查路径是否为目录（如 ~/dir）
  --     if vim.fn.isdirectory(file_path) == 1 then
  --       vim.cmd("tcd " .. file_path) -- 切换到目标目录
  --     else
  --       vim.cmd("tcd " .. matinaState.rootDir) -- 切换到目标目录
  --     end
  --   end,
  -- })
end
