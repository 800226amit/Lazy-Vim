-- =============================================
-- 🚀 ULTIMATE NEOVIM CONFIGURATION
-- Simple yet Powerful - Production Ready
-- =============================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load all modules
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("plugins.lazy-setup")

-- Theme activation
vim.cmd.colorscheme("catppuccin")

-- Welcome message
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.notify("🚀 Ultimate Neovim Loaded Successfully!", "info", {
      title = "Welcome",
      timeout = 2000,
    })
  end
})
