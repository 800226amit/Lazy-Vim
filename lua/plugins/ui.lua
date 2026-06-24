-- =============================================
-- UI Plugins - Beautiful Interface
-- =============================================

return {
  -- Color scheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        term_colors = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          telescope = true,
          notify = true,
          mason = true,
          which_key = true,
          indent_blankline = { enabled = true },
        },
      })
    end
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
      })
    end
  },

  -- Buffer tabs
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "ordinal",
          diagnostics = "nvim_lsp",
          separator_style = "slant",
          show_buffer_close_icons = true,
          show_close_icon = false,
          color_icons = true,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
              separator = true,
            }
          },
        }
      })
    end
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = {
          width = 35,
          side = "left",
        },
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
          highlight_git = true,
          indent_markers = { enable = true },
        },
        filters = {
          dotfiles = false,
          custom = { "^.git$" },
        },
        git = {
          enable = true,
          ignore = false,
        },
      })
    end
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ibl").setup({
        indent = {
          char = "▏",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
        },
      })
    end
  },

  -- Colorizer
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end
  },

  -- Notification manager
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        fps = 60,
        render = "compact",
        timeout = 3000,
        top_down = false,
      })
      vim.notify = require("notify")
    end
  },

  -- Better UI inputs
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
        "           🚀 Ultimate Neovim - Ready to Code 🚀     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "  Find text", ":Telescope live_grep<CR>"),
        dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("u", "  Update", ":Lazy sync<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      alpha.setup(dashboard.opts)
    end
  },

  -- Which-key (shows keybindings)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        plugins = {
          spelling = { enabled = true },
        },
      })
    end,
  },

  -- Smooth scrolling (<C-b>/<C-f> removed — those keys used by NvimTree/Telescope)
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
      })
    end
  },

  -- Better cmdline + notifications UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          format = {
            cmdline   = { icon = ">" },
            search_down = { icon = " " },
            search_up   = { icon = " " },
          },
        },
        messages  = { enabled = true },
        popupmenu = { enabled = true, backend = "nui" },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          progress = { enabled = true },
          hover    = { enabled = true },
          signature = { enabled = true },
        },
        presets = {
          bottom_search     = false,
          command_palette   = true,
          long_message_to_split = true,
          lsp_doc_border    = true,
        },
      })
    end,
  },

  -- Which-key with groups
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout    = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")
      wk.setup({ plugins = { spelling = { enabled = true } } })
      wk.register({
        ["<leader>f"] = { name = " Find (Telescope)" },
        ["<leader>g"] = { name = " Git" },
        ["<leader>l"] = { name = " LSP / Format" },
        ["<leader>h"] = { name = "󱡁 Harpoon" },
        ["<leader>s"] = { name = " Splits / Sessions / Search" },
        ["<leader>x"] = { name = " Diagnostics" },
        ["<leader>a"] = { name = "󰙣 Aerial Outline" },
      })
    end,
  },
}
