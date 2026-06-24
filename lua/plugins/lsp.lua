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

      -- Use Neovim 0.11+ native vim.lsp.config API (no lspconfig "framework" warning)
      -- Lua — special settings
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics    = { globals = { "vim" } },
            workspace      = {
              library        = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- All other servers with default capabilities
      local all_servers = {
        "ts_ls", "pyright",
        "html", "cssls", "tailwindcss", "jsonls",
        "rust_analyzer", "gopls", "clangd", "bashls",
      }
      for _, server in ipairs(all_servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end

      -- mason-lspconfig auto-enables installed servers
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          vim.lsp.enable(server_name)
        end,
      })

      -- LSP attach autocmd: buffer-local keymaps + inlay hints
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local opts = { buffer = bufnr, silent = true }

          -- Go to definition/references via Telescope
          vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>",      vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>",       vim.tbl_extend("force", opts, { desc = "Find all references" }))
          vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>",  vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
          vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
          vim.keymap.set("n", "K",  vim.lsp.buf.hover,                         vim.tbl_extend("force", opts, { desc = "Hover docs" }))
          vim.keymap.set("n", "<leader>rn",
            function() return ":IncRename " .. vim.fn.expand("<cword>") end,
            vim.tbl_extend("force", opts, { expr = true, desc = "Rename symbol (live preview)" }))
          vim.keymap.set("n", "<F2>",
            function() return ":IncRename " .. vim.fn.expand("<cword>") end,
            vim.tbl_extend("force", opts, { expr = true, desc = "Rename (F2, live preview)" }))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,           vim.tbl_extend("force", opts, { desc = "Code action" }))
          vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "References" }))
          vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", vim.tbl_extend("force", opts, { desc = "Symbols" }))

          -- Ctrl+Click -> go to definition
          vim.keymap.set("n", "<C-LeftMouse>", "<LeftMouse><cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Go to definition (click)" }))

          -- Enable inlay hints if supported
          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
      })
    end
  }
}
