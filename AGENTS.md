# Neovim Configuration Handover Document

## Project Overview

This is a highly customized LazyVim-based Neovim configuration designed for modern development workflows. The configuration provides extensive AI integration, multi-language development support, and enhanced productivity features.

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

#### Avante.nvim
- **Primary AI Provider**: Claude Code with DeepSeek as alternative
- **Activation**: `<C-=>` to toggle Avante chat
- **Selection-based Editing**: `<leader>ae` (edit) and `<leader>aa` (ask) on selected text
- **Codebase Awareness**: Enabled for context-aware assistance
- **System Prompt**: Custom Chinese-focused prompt with MCP server integration

#### MCP Hub
- **Port**: 37373
- **Auto-approval**: Enabled for MCP tool calls
- **Server Management**: Automatic start/stop of MCP servers
- **Avante Integration**: Slash commands from MCP server prompts

#### GitHub Copilot
- **Integration**: Through blink.cmp completion framework
- **Configuration**: Auto-trigger disabled when AI completion is enabled

### Development Support

#### Language Server Protocol (LSP)
- **vtsls**: TypeScript/JavaScript with enhanced features
- **gopls**: Go with extensive hinting and analysis
- **dartls**: Dart/Flutter with FVM support
- **eslint**: Auto-formatting and validation
- **cssls**: CSS/LESS/SCSS support

#### Mason Package Manager
**Automatically Installed Tools:**
- **LSP Servers**: lua-language-server, pyright, bash-language-server, json-lsp, yaml-language-server, html-lsp, css-lsp, gopls
- **Formatters**: stylua, shellcheck, shfmt, flake8, prettier, goimports, gofumpt
- **Debuggers**: js-debug-adapter, delve
- **Utilities**: ast-grep, dockerfile-language-server, eslint_d, protols

#### Flutter Development
- **FVM Support**: Enabled for Flutter version management
- **Debugger**: DAP integration with evaluate-to-string
- **UI Features**: Closing tags, device statusline, color highlighting
- **Excluded Folders**: build/, ios/, android/, platform-specific directories

### UI/UX Enhancements

#### Themes
- **Primary**: Tokyo Night with transparent background
- **Customizations**: Transparent sidebars and floating windows
- **Dashboard**: Custom ASCII art header with Snacks.nvim

#### Buffer Management
- **Bufferline.nvim**: Enhanced tab and buffer management
- **Features**: Diagnostics indicators, custom name formatting
- **Styling**: Minimal preset with underline indicators

#### Noice.nvim
- **Enhanced Notifications**: Custom routing for different message types
- **LSP Integration**: Hover documentation in split windows
- **Error Filtering**: Suppresses ESLint and DartLS noise

### Code Quality

#### Formatting
- **Conform.nvim**: Multi-formatter support
- **ESLint Integration**: Auto-formatting for JavaScript/TypeScript
- **Prettier**: Primary formatter for multiple filetypes
- **Trigger**: `<M-F>` for comprehensive formatting (ESLint + Prettier)

#### Treesitter
- **Enhanced Parsing**: Support for multiple languages
- **Filetype Extensions**: Custom mappings for kitty, hyprlang, rasi files
- **Language Support**: bash, html, javascript, json, lua, markdown, python, typescript, vue, go, dart, css

## Key Mappings

### Navigation & Terminal
- `<leader>ft` / `<C-/>`: Toggle terminal in current directory
- `<leader>fT` / `<C-\>`: Toggle terminal in split
- `<C-M-Left/Right/Up/Down>`: Window resizing

### AI & Development
- `<C-=>`: Toggle Avante AI chat
- `<leader>ad`: Clear Avante chat history
- `<leader>ae` / `<leader>aa`: Avante edit/ask on selected text
- `g.`: Open code actions menu
- `gh`: Show LSP hover documentation

### System Integration
- `<D-s>`: Save file (macOS)
- `<D-a>`: Select all
- `<D-c>` / `<D-x>`: Copy/cut to system clipboard
- `jj`: Quick escape from insert mode
- `<M-F>`: Format code with ESLint integration

### TypeScript/JavaScript Specific
- `<D-F>`: TTSFixAndFormat (TypeScript Tools fix and format)
- `<leader>co`: Organize imports
- `<leader>cM`: Add missing imports
- `<leader>cu`: Remove unused imports
- `<leader>cD`: Fix all diagnostics

## Configuration Details

### Auto Commands

#### Filetype-specific Settings
- **2-space indentation**: Lua, JavaScript, TypeScript, Dart
- **4-space indentation**: General files
- **Smart indentation**: Enabled for programming languages

#### Terminal Integration
- **Automatic Directory Switching**: Based on project root
- **Environment Variables**: Unique instance IDs for terminal sessions
- **Project Detection**: Via `.git`, `pubspec.yaml`, etc.

### Environment Variables

#### Required for AI Integration
```bash
ANTHROPIC_AUTH_TOKEN=your_claude_api_token
ANTHROPIC_MODEL=claude-3-7-sonnet
ANTHROPIC_SMALL_FAST_MODEL=claude-3-7-fast
CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
```

#### Optional
```bash
DEEPSEEK_API_KEY=your_deepseek_api_key
```

### Completion Framework

#### Blink.cmp
- **Sources**: LSP, Avante, path, snippets, buffer, copilot
- **Features**: Auto-brackets, ghost text, documentation
- **Keymaps**: Super-tab preset with custom accept/cancel

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

## Troubleshooting

### Common Issues

#### ESLint Configuration
- Ensure `eslint_d` is installed via Mason
- Check project has valid ESLint configuration
- Auto-formatting can be disabled via `vim.g.lazyvim_eslint_auto_format = false`

#### Flutter Development
- Verify FVM is installed and configured
- Check Dart SDK path in Flutter installation
- Excluded folders configured to improve performance

#### AI Integration
- Verify API tokens are set in environment variables
- Check MCP Hub server is running on port 37373
- Avante provider can be switched between Claude Code and DeepSeek

#### Terminal Issues
- Verify workspace directory exists and is accessible
- Check unique instance ID generation
- Terminal sessions maintain separate environments

### Performance Optimization

#### Disabled Features
- **gzip**: Disabled for performance
- **tarPlugin**: Disabled
- **tohtml**: Disabled
- **tutor**: Disabled
- **zipPlugin**: Disabled

#### LSP Optimization
- **DartLS**: Excluded folders configured for better performance
- **vtsls**: Enhanced TypeScript features with inlay hints
- **gopls**: Comprehensive Go analysis with staticcheck

## Migration & Updates

### Plugin Updates
- Lazy.nvim automatically checks for updates
- Mason ensures LSP servers are up to date
- Manual updates via `:Lazy update`

### Configuration Changes
- Custom configurations in `lua/plugins/` directory
- Core LazyVim settings can be overridden
- Keymaps and options are extensible

## Support & Resources

### Documentation
- **LazyVim**: https://lazyvim.org/
- **Avante.nvim**: https://github.com/yetone/avante.nvim
- **MCP Hub**: https://github.com/ravitemer/mcphub.nvim
- **Flutter Tools**: https://github.com/nvim-flutter/flutter-tools.nvim

### Key Files for Customization
- `lua/plugins/happyvim.lua`: Main plugin configuration
- `lua/config/keymaps.lua`: Custom key mappings
- `lua/config/options.lua`: Global options
- `lua/config/autocmds.lua`: Auto commands

---

*This handover document was generated based on the current Neovim configuration state. Configuration may evolve over time - refer to the actual files for the most current implementation.*