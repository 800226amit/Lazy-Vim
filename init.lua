-- =============================================
-- Neovim Configuration - Enhanced Version
-- =============================================

-- Leader key setup (must be before any keymaps)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable true colors and better UI
vim.opt.termguicolors = true
vim.opt.cmdheight = 1
vim.opt.showmode = false
vim.opt.title = true

-- =============================================
-- Plugin Management (Lazy.nvim)
-- =============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- =============================================
  -- LSP (Language Server Protocol) Configuration
  -- =============================================
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",           -- LSP installer
      "williamboman/mason-lspconfig.nvim", -- Bridge between mason and lspconfig
      "hrsh7th/cmp-nvim-lsp",             -- LSP completion source
    },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",          -- Lua
          "jdtls",          -- Java
          "tsserver",       -- TypeScript/JavaScript
          "html",           -- HTML
          "cssls",          -- CSS
          "tailwindcss",    -- Tailwind CSS
          "clangd",         -- C/C++
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configure each language server
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        jdtls = {},                    -- Java
        tsserver = {},                 -- TypeScript/JavaScript
        html = {},                     -- HTML
        cssls = {},                    -- CSS
        tailwindcss = {},             -- Tailwind CSS
        clangd = {},                  -- C/C++
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end
    end
  },

  -- =============================================
  -- Autocompletion
  -- =============================================
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",        -- LSP completion
      "hrsh7th/cmp-buffer",          -- Buffer completion
      "hrsh7th/cmp-path",            -- File path completion
      "hrsh7th/cmp-cmdline",         -- Command line completion
      "L3MON4D3/LuaSnip",           -- Snippet engine
      "saadparwaiz1/cmp_luasnip",   -- Snippet completion
      "rafamadriz/friendly-snippets", -- Collection of snippets
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, vim_item)
            -- Add icons for different completion sources
            local icons = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "",
            }
            vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)
            return vim_item
          end,
        },
      })

      -- Command line completion
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
    end
  },

  -- =============================================
  -- Syntax Highlighting and Parsing
  -- =============================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "query",
          "javascript", "typescript", "tsx",
          "html", "css", "java", "cpp", "c",
          "json", "yaml", "markdown"
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end
  },

  -- =============================================
  -- UI Enhancements
  -- =============================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          icons_enabled = true,
        },
        sections = {
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
      })
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        integrations = {
          cmp = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
        },
      })
    end
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    end
  },

  -- Fuzzy Finder
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "🔍 ",
          color_devicons = true,
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
          },
          sorting_strategy = "ascending",
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })
      require("telescope").load_extension("fzf")
    end
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          else
            return 20
          end
        end,
        open_mapping = false,
        direction = "float",
        float_opts = {
          border = "rounded",
          winblend = 3,
        },
        persist_size = true,
        persist_mode = true,
        close_on_exit = true,
      })
    end
  },

  -- =============================================
  -- Additional Helpful Plugins
  -- =============================================
  
  -- Auto pairs for brackets, quotes, etc.
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end
  },

  -- Comment toggling
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },

  -- Better UI for LSP diagnostics, references, etc.
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
    end
  },
})

-- =============================================
-- Core Editor Settings
-- =============================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- =============================================
-- Key Mappings
-- =============================================

-- ===== FAMILIAR KEYBINDINGS (Ctrl+S, Ctrl+A, etc.) =====
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>", { desc = "Save file in insert mode" })
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
vim.keymap.set("i", "<C-a>", "<C-o>ggVG", { desc = "Select all in insert mode" })
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("i", "<C-v>", '<C-o>"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Paste from system clipboard" })

-- ===== LSP KEYBINDINGS =====
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation" })
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code" })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<Up>", ":resize -2<CR>")
vim.keymap.set("n", "<Down>", ":resize +2<CR>")

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- Terminal
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle vertical terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-q>", "<cmd>close<CR>", { noremap = true, desc = "Close terminal" })

-- Comments
vim.keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { desc = "Comment line" })
vim.keymap.set("x", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Comment selection" })

-- Trouble (diagnostics)
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Toggle trouble" })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Workspace diagnostics" })

-- Misc
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- =============================================
-- UI Setup
-- =============================================
vim.cmd.colorscheme("catppuccin")

-- =============================================
-- Autocommands
-- =============================================
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end
})

-- Terminal settings
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end
})

-- Auto-create directories for undo files
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local undodir = vim.fn.stdpath("data") .. "/undodir"
    if vim.fn.isdirectory(undodir) == 0 then
      vim.fn.mkdir(undodir, "p")
    end
  end
})

-- LSP configuration for better diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Define diagnostic signs
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
