# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim-based Neovim configuration with extensive customization for modern development workflows. The configuration is built on LazyVim as a foundation and adds numerous plugins and customizations for enhanced productivity.

## Architecture

### Core Structure
- **`init.lua`**: Entry point that loads LazyVim and custom plugins
- **`lua/config/`**: Core configuration files
  - `lazy.lua`: Lazy.nvim plugin manager setup
  - `keymaps.lua`: Custom key mappings and shortcuts
  - `options.lua`: Neovim options and global variables
  - `autocmds.lua`: Auto commands and filetype-specific settings
- **`lua/plugins/`**: Custom plugin configurations
  - `happyvim.lua`: Main plugin configuration with extensive customizations
  - `my_mcphub.lua`: MCP Hub configuration for AI tools
  - `flutter-tools.lua`: Flutter development setup
  - `noice.nvim`: UI enhancements and notification routing
  - `themes.lua`: Theme configurations
  - `autosave.lua`: Auto-save functionality

### Plugin Management
- Uses Lazy.nvim for plugin management
- Custom plugins are loaded from `lua/plugins/` directory
- LazyVim provides the foundation with additional extras enabled

## Key Features

### AI Integration
- **Avante.nvim**: AI chat and code assistance with Claude Code integration
- **MCP Hub**: Model Context Protocol server management for AI tools
- **Copilot**: GitHub Copilot integration with custom configuration
- **Blink.cmp**: Enhanced completion framework with AI sources

### Development Support
- **Flutter Tools**: Full Flutter development support with FVM
- **TypeScript/JavaScript**: Enhanced LSP configuration with vtsls
- **Go**: Comprehensive Go development with gopls
- **Dart**: Dart language server with Flutter integration
- **Multiple Languages**: Support for Python, Rust, PHP, Vue, and more

### UI/UX Enhancements
- **Snacks.nvim**: Custom picker and dashboard
- **Noice.nvim**: Enhanced notifications and UI components
- **Bufferline.nvim**: Tab and buffer management
- **Tokyo Night**: Default color scheme with transparent background

### Code Quality
- **Conform.nvim**: Formatting with Prettier and ESLint integration
- **ESLint**: Auto-formatting enabled for JavaScript/TypeScript
- **Treesitter**: Enhanced syntax highlighting and parsing
- **LSP**: Comprehensive language server protocol setup

## Key Mappings

### Navigation
- `<leader>ft` / `<C-/>`: Toggle terminal in current directory
- `<leader>fT` / `<C-\>`: Toggle terminal in split
- `<C-=>`: Toggle Avante AI chat
- `<M-F>`: Format code with ESLint integration

### Development
- `g.`: Open code actions menu
- `gh`: Show LSP hover documentation
- `<leader>ad`: Clear Avante chat history
- `<leader>ae` / `<leader>aa`: Avante edit/ask on selected text

### System Integration
- `<D-s>`: Save file (macOS)
- `<D-a>`: Select all
- `<D-c>` / `<D-x>`: Copy/cut to system clipboard
- `jj`: Quick escape from insert mode

## Configuration Details

### LSP Servers
- **vtsls**: TypeScript/JavaScript with enhanced features
- **gopls**: Go with extensive hinting and analysis
- **dartls**: Dart/Flutter with FVM support
- **eslint**: Auto-formatting and validation
- **cssls**: CSS/LESS/SCSS support

### Formatting
- Auto-formatting enabled for multiple filetypes
- ESLint integration for JavaScript/TypeScript
- Prettier as primary formatter
- Custom formatting triggers and keymaps

### Terminal Integration
- Automatic directory switching based on project
- Multiple terminal instances with unique IDs
- Custom environment variables for terminal sessions

### AI Tools Configuration
- Claude Code as primary AI provider
- DeepSeek as alternative provider
- MCP Hub for tool integration
- Custom system prompts and tool management

## Development Workflow

### Starting Development
1. Open Neovim - configuration auto-loads
2. Terminal automatically switches to workspace directory
3. LSP servers auto-start for supported filetypes
4. AI tools available via `<C-=>` for Avante chat

### Code Formatting
- Use `<M-F>` for comprehensive formatting (ESLint + Prettier)
- Auto-format on save for supported filetypes
- Manual formatting available via LazyVim commands

### AI Assistance
- Toggle Avante with `<C-=>`
- Use selection-based editing with `<leader>ae`
- Access codebase-aware AI assistance
- MCP tools available through Avante interface

## Customization Notes

### Theme
- Tokyo Night with transparent background
- Custom dashboard header with ASCII art
- Transparent sidebars and floating windows

### Filetype Settings
- 2-space indentation for most languages (Lua, JavaScript, TypeScript, Dart)
- 4-space indentation for general files
- Smart indentation and auto-indent enabled

### Environment Variables
- Automatic workspace directory detection
- Unique instance IDs for terminal sessions
- Project root detection via `.git`, `pubspec.yaml`, etc.