return {
  {
    -- "ellisonleao/gruvbox.nvim",
    {
      "folke/tokyonight.nvim",
      opts = {
        style = "moon",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      },
    },
    {
      "LazyVim/LazyVim",
      opts = {
        -- colorscheme = "gruvbox",
        -- colorscheme = "catppuccin-mocha",
        -- colorscheme = "catppuccin",
        colorscheme = "tokyonight",
      },
    },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      event = "BufReadPost",
      opts = {
        suggestion = {
          enabled = not vim.g.ai_cmp,
          hide_during_completion = vim.g.ai_cmp,
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      },
    },
    -- change trouble config
    {
      "folke/trouble.nvim",
      -- opts will be merged with the parent spec
      opts = { use_diagnostic_signs = true },
    },

    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if vim.g.vscode then
        -- pass
        else
          local function add(lang)
            if type(opts.ensure_installed) == "table" then
              table.insert(opts.ensure_installed, lang)
            end
          end
          vim.list_extend(opts.ensure_installed, {
            "bash",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "tsx",
            "typescript",
            "vim",
            "yaml",
            "css",
            "vue",
            "go",
            "scss",
            "less",
            "gomod",
            "gowork",
            "dart",
            "gosum",
            "jsdoc",
            "git_config",
            "gitcommit",
            "git_rebase",
            "gitignore",
            "gitattributes",
          })

          vim.filetype.add({
            extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
            filename = {
              ["vifmrc"] = "vim",
            },
            pattern = {
              [".*/waybar/config"] = "jsonc",
              [".*/mako/config"] = "dosini",
              [".*/kitty/.+%.conf"] = "kitty",
              [".*/hypr/.+%.conf"] = "hyprlang",
              ["%.env%.[%w_.-]+"] = "sh",
            },
          })
          vim.treesitter.language.register("bash", "kitty")

          add("git_config")
        end
      end,
    },

    {
      "MeanderingProgrammer/render-markdown.nvim",
      file_types = { "markdown", "Avante" },
    },
    {
      "HakonHarnes/img-clip.nvim",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
  -- {
  --   "sphamba/smear-cursor.nvim",
  --   event = "VeryLazy",
  --   cond = vim.g.neovide == nil and vim.env.TERM_PROGRAM ~= "ghostty",
  -- },
  -- {
  --   "akinsho/bufferline.nvim",
  --   opts = {
  --     options = {
  --       -- mode = "tabs",
  --       always_show_bufferline = true,
  --       show_tab_indicators = true,
  --       style_preset = require("bufferline").style_preset.minimal,
  --
  --       -- separator styles: slant, padded_slant, slope, padded_slope, thick, thin
  --       separator_style = { " ", " " },
  --
  --       indicator = {
  --         style = "underline",
  --         -- Custom indicator color
  --         color = "#60A5FA", -- blue-400 for active indicator
  --       },
  --
  --       color_icons = true,
  --
  --       -- Better buffer ordering
  --       sort_by = "insert_after_current",
  --
  --       -- Enhanced buffer styling
  --       diagnostics = "nvim_lsp",
  --       diagnostics_indicator = function(count, level, diagnostics_dict, context)
  --         local icon = level:match("error") and " " or " "
  --         return " " .. icon .. count
  --       end,
  --
  --       -- Custom buffer name formatting
  --       name_formatter = function(buf)
  --         -- Remove directory path and show only filename
  --         local name = buf.name
  --         if name and name:match(".*[/\\]") then
  --           name = name:match("([^/\\]+)$")
  --         end
  --         return name
  --       end,
  --     },
  --   },
  -- },
}
