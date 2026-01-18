-- =============================================
-- Lazy.nvim Plugin Manager Setup
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
  -- Import plugin configurations from separate files
  { import = "plugins.lsp" },           -- LSP configuration
  { import = "plugins.completion" },    -- Completion and snippets
  { import = "plugins.editor" },        -- Editor enhancements
  { import = "plugins.ui" },            -- UI improvements
  { import = "plugins.navigation" },    -- File navigation and search
  { import = "plugins.git" },           -- Git integration
  { import = "plugins.terminal" },      -- Terminal integration
  { import = "plugins.frameworks" },    -- Framework-specific features
  { import = "plugins.debugging" },     -- Debugging support
  { import = "plugins.testing" },       -- Testing integration
}, {
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})