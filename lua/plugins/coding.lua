-- =============================================
-- Coding Tools - Enhanced Development
-- =============================================

return {
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
        },
      })

      -- Integration with cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("Comment").setup()
    end
  },

  -- Surround text objects
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },

  -- Code formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          rust = { "rustfmt" },
          go = { "gofmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },

  -- Multi-cursor
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
      }
    end,
  },

  -- Better escape
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mapping = { "jk", "jj" },
        timeout = 200,
        clear_empty_lines = false,
        keys = "<Esc>",
      })
    end,
  },

  -- Rust: Cargo.toml mein crate versions dikhao + auto-suggest latest version
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        completion = {
          cmp = { enabled = true },   -- nvim-cmp ke saath integrate
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
      -- Cargo.toml mein shortcuts
      local map = vim.keymap.set
      map("n", "<leader>cu", function() require("crates").upgrade_all_crates() end,
        { desc = "Crates: upgrade all" })
      map("n", "<leader>co", function() require("crates").show_popup() end,
        { desc = "Crates: show versions" })
      map("n", "<leader>cf", function() require("crates").show_features_popup() end,
        { desc = "Crates: show features" })
    end,
  },

  -- NPM: package.json mein package versions dikhao
  {
    "vuki656/package-info.nvim",
    event = { "BufRead package.json" },
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("package-info").setup({
        colors = {
          up_to_date = "#3C4048",
          outdated   = "#d19a66",
        },
        icons = {
          enable = true,
          style  = { up_to_date = "|  ", outdated = "|  " },
        },
        autostart          = true,
        hide_unstable_versions = true,
        package_manager    = "npm",
      })
      local map = vim.keymap.set
      map("n", "<leader>ns", function() require("package-info").show() end,
        { desc = "NPM: show versions" })
      map("n", "<leader>nu", function() require("package-info").update() end,
        { desc = "NPM: update package" })
      map("n", "<leader>ni", function() require("package-info").install() end,
        { desc = "NPM: install package" })
      map("n", "<leader>nd", function() require("package-info").delete() end,
        { desc = "NPM: delete package" })
    end,
  },

  -- NPM package names auto-complete in package.json
  {
    "David-Kunz/cmp-npm",
    event = { "BufRead package.json" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("cmp-npm").setup({ ignore = {}, only_semantic_versions = false })
    end,
  },
}
