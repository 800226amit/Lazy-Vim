-- =============================================
-- LSP Configuration - Language Servers
-- =============================================

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      -- Setup neodev for Lua
      require("neodev").setup()

      -- Mason setup
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      -- Servers to install
      local servers = {
        "lua_ls",          -- Lua
        "ts_ls",           -- TypeScript/JavaScript
        "html",            -- HTML
        "cssls",           -- CSS
        "tailwindcss",     -- Tailwind
        "jsonls",          -- JSON
        "pyright",         -- Python
        "rust_analyzer",   -- Rust
        "gopls",           -- Go
        "clangd",          -- C/C++
        "bashls",          -- Bash
      }

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      -- LSP capabilities with nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = "if_many",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Diagnostic signs
      local signs = {
        Error = " ",
        Warn = " ",
        Hint = "󰌶 ",
        Info = " "
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Server-specific settings
      local lspconfig = require("lspconfig")

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          }
        }
      })

      -- TypeScript/JavaScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      -- Python
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      -- Other servers with default config
      local default_servers = {
        "html", "cssls", "tailwindcss", "jsonls",
        "rust_analyzer", "gopls", "clangd", "bashls"
      }

      for _, server in ipairs(default_servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end

      -- LSP attach autocmd for keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- Enable inlay hints if supported
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
      })
    end
  }
}
