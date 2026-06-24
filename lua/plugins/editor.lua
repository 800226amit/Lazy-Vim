-- =============================================
-- Editor Enhancements - Productivity Tools
-- =============================================

return {
  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 3,
        },
      })
    end
  },

  -- Diagnostics panel
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
    end
  },

  -- TODO comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("todo-comments").setup()
    end
  },

  -- Zen mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require("zen-mode").setup({
        window = {
          width = 120,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
          },
        },
      })
    end
  },

  -- Undo tree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    config = function()
      vim.g.undotree_WindowLayout = 3
      vim.g.undotree_SetFocusWhenToggle = 1
    end
  },

  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize" }
    },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Project-wide search & replace (Spectre)
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Spectre",
    config = function()
      require("spectre").setup({
        open_cmd = "noswapfile vnew",
        live_update = true,
        highlight = {
          ui      = "String",
          search  = "DiffChange",
          replace = "DiffDelete",
        },
      })
    end,
  },

  -- Code outline / symbol tree (keyboard-navigable)
  {
    "stevearc/aerial.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup({
        backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
        layout = {
          max_width        = { 40, 0.2 },
          min_width        = 25,
          default_direction = "right",
          placement        = "edge",
        },
        show_guides = true,
        attach_mode = "window",
        filter_kind = {
          "Class", "Constructor", "Enum", "Function",
          "Interface", "Module", "Method", "Struct",
        },
        highlight_on_hover = true,
        autojump = false,
        open_automatic = false,
      })
      require("telescope").load_extension("aerial")
    end,
  },

  -- Live-preview rename (replaces plain lsp rename)
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = function()
      require("inc_rename").setup()
    end,
  },

  -- Auto-close HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close         = true,
          enable_rename        = true,
          enable_close_on_slash = true,
        },
      })
    end,
  },

  -- Highlight word under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        delay = 200,
        under_cursor = true,
        filetypes_denylist = {
          "NvimTree",
          "Trouble",
          "alpha",
        },
      })
    end
  },

  -- Flash (enhanced search)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
}
