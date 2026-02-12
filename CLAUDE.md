# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

这是一个基于LazyVim构建的Neovim配置，针对现代开发工作流程进行了广泛定制。它以LazyVim为基础框架，添加了众多插件和自定义设置以增强生产力。

## 架构与结构

### 核心结构
- **`init.lua`**: 配置入口点，加载LazyVim和自定义插件
- **`lua/config/`**: 核心配置文件目录
  - `lazy.lua`: Lazy.nvim插件管理器的设置
  - `keymaps.lua`: 自定义键位映射和快捷方式
  - `options.lua`: Neovim选项和全局变量设置
  - `autocmds.lua`: 自动命令和文件类型特定设置
- **`lua/plugins/`**: 自定义插件配置目录
  - `happyvim.lua`: 主插件配置，包含大量自定义设置
  - `ai.lua`: AI相关插件配置
  - `my_mcphub.lua`: MCP Hub配置用于AI工具
  - `flutter-tools.lua`: Flutter开发环境设置
  - `nvim-lspconfig.lua`: LSP服务器配置
  - `noice.nvim`: UI增强和通知路由
  - `themes.lua`: 主题配置

### 插件管理
- 使用 **Lazy.nvim** 作为插件管理器
- 自定义插件从 `lua/plugins/` 目录加载
- LazyVim提供基础框架，额外启用了一些增强功能
- `lazy-lock.json` 包含插件的固定版本信息

## 关键功能领域

### AI集成
- **Avante.nvim**: AI聊天和代码辅助，支持Claude Code集成
- **MCP Hub**: Model Context Protocol服务器管理，用于AI工具
- **Copilot**: GitHub Copilot集成，带有自定义配置
- **Blink.cmp**: 增强的自动补全框架，带有AI来源

### 开发支持
- **Flutter开发**: 完整的Flutter开发支持，包括FVM
- **TypeScript/JavaScript**: 使用vtsls的增强LSP配置
- **Go开发**: 使用gopls的综合Go开发支持
- **Dart开发**: 带有Flutter集成的Dart语言服务器
- **多语言支持**: Python, Rust, PHP, Vue等

### 代码质量与格式化
- **Conform.nvim**: 使用Prettier和ESLint进行格式化
- **ESLint**: 对JavaScript/TypeScript启用自动格式化
- **LSP**: 综合的语言服务器协议设置
- **按键映射**: `<M-F>` 用于代码格式化，自动执行ESLint修复

## 核心命令与工作流

### 插件管理命令
```bash
:Lazy      # 打开Lazy.nvim插件管理器
:Lazy sync # 更新插件并同步配置
:Lazy clean# 清理未使用的插件
```

### 开发相关命令
```bash
:EslintFixAll      # 执行ESLint修复（仅JavaScript/TypeScript）
:Format            # 使用Conform.nvim格式化当前文件
:Neotest run       # 运行当前测试文件
:Neotest run file  # 运行当前文件的所有测试
:Neotest attach    # 附加到测试会话
```

### AI工具命令
```bash
<C-=>               # 切换Avante AI聊天界面
<leader>ae          # 对选中的文本进行AI编辑
<leader>aa          # 对选中的文本进行AI询问
<leader>ad          # 清除Avante聊天历史
```

## 配置特点与注意事项

### 主题与UI
- 默认使用 **Tokyo Night** 配色方案，带有透明背景
- 自定义仪表板头部，包含ASCII艺术
- 透明侧边栏和浮动窗口

### 文件类型设置
- 大多数语言使用2空格缩进 (Lua, JavaScript, TypeScript, Dart)
- 通用文件使用4空格缩进
- 启用智能缩进和自动缩进

### LSP服务器配置
核心LSP服务器在 `lua/plugins/nvim-lspconfig.lua` 中配置，包括:
- vtsls (TypeScript/JavaScript)
- gopls (Go)
- dartls (Dart/Flutter)
- eslint (代码风格检查)

### 开发工作流
1. 打开Neovim - 配置自动加载
2. 终端自动切换到工作区目录
3. LSP服务器为支持的文件类型自动启动
4. 可通过 `<C-=>` 访问AI工具

## 自定义建议

- 若要添加新插件，请在 `lua/plugins/` 目录下创建新的Lua文件
- 若要修改键位映射，编辑 `lua/config/keymaps.lua`
- 若要调整Neovim选项，编辑 `lua/config/options.lua`
- 若要添加自动命令，编辑 `lua/config/autocmds.lua`