#!/usr/bin/env bash

set -e

BASE="$HOME/.config/nvim"

# Create directories
mkdir -p $BASE/{lua/{config,core,plugins/{core,ui,navigation,git,editing,languages,debugging,testing}},after/plugin,snippets/{python,javascript,typescript,lua}}

# --- Write files ---

# init.lua
cat > $BASE/init.lua <<'EOF'
-- ~/.config/nvim/init.lua
vim.loader = true -- enable Lua module loader
require("core.init")
require("core.lazy")
EOF

# lua/core/init.lua
cat > $BASE/lua/core/init.lua <<'EOF'
local M = {}
M.setup = function()
  require("config.options")
  require("config.keymaps")
  require("config.autocommands")
  require("config.globals")
end
M.setup()
return M
EOF

# lua/core/lazy.lua
cat > $BASE/lua/core/lazy.lua <<'EOF'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("plugins.init")
EOF

# lua/plugins/init.lua
cat > $BASE/lua/plugins/init.lua <<'EOF'
local plugins = {
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'nvim-lua/popup.nvim', lazy = true },

  {
    'rmehri01/onenord.nvim',
    name = 'onenord',
    config = function() require('plugins.core.colorscheme') end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function() require('plugins.core.treesitter') end,
  },

  {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.core.lsp') end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function() require('plugins.core.completion') end,
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('plugins.core.telescope') end,
  },

  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require('plugins.navigation.nvim-tree') end,
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.git.gitsigns') end,
  },

  {
    'windwp/nvim-autopairs',
    config = function() require('plugins.editing.autopairs') end,
  },
  {
    'numToStr/Comment.nvim',
    config = function() require('plugins.editing.comments') end,
  },
}

local opts = { install = { colorscheme = { 'onenord' } } }
require('lazy').setup(plugins, opts)
EOF

# lua/config/options.lua
cat > $BASE/lua/config/options.lua <<'EOF'
local o = vim.opt
o.number = true
o.relativenumber = true
o.clipboard = 'unnamedplus'
o.mouse = 'a'
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.wrap = false
o.scrolloff = 8
o.signcolumn = 'yes'
EOF

# lua/config/keymaps.lua
cat > $BASE/lua/config/keymaps.lua <<'EOF'
local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
vim.g.mapleader = ' '
map('n', '<leader>w', ':w<CR>', default_opts)
map('n', '<leader>q', ':q<CR>', default_opts)
map('n', '<leader>p', ":Telescope find_files<CR>", default_opts)
EOF

# lua/config/autocommands.lua
cat > $BASE/lua/config/autocommands.lua <<'EOF'
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.lua',
  callback = function() vim.lsp.buf.format({ async = false }) end,
})
EOF

# lua/config/globals.lua
cat > $BASE/lua/config/globals.lua <<'EOF'
vim.g.mapleader = ' '
vim.g.python3_host_prog = '/usr/bin/python3'
EOF

# lua/config/utils.lua
cat > $BASE/lua/config/utils.lua <<'EOF'
local M = {}
function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
return M
EOF

# plugin configs
cat > $BASE/lua/plugins/core/colorscheme.lua <<'EOF'
vim.cmd([[colorscheme onenord]])
vim.o.termguicolors = true
EOF

cat > $BASE/lua/plugins/core/treesitter.lua <<'EOF'
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'lua', 'python', 'javascript', 'json', 'go', 'rust' },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  indent = { enable = true },
}
EOF

cat > $BASE/lua/plugins/core/lsp.lua <<'EOF'
local lspconfig = require('lspconfig')
local on_attach = function(_, bufnr)
  local buf_map = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end
  buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
end
local servers = { 'pyright', 'bashls', 'tsserver', 'gopls', 'rust_analyzer', 'lua_ls' }
for _, lsp in ipairs(servers) do
  pcall(function() lspconfig[lsp].setup({ on_attach = on_attach }) end)
end
EOF

cat > $BASE/lua/plugins/core/completion.lua <<'EOF'
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' } }),
})
EOF

cat > $BASE/lua/plugins/core/telescope.lua <<'EOF'
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = { mappings = { i = { ['<esc>'] = actions.close } } }
}
vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true, silent = true })
EOF

cat > $BASE/lua/plugins/navigation/nvim-tree.lua <<'EOF'
require('nvim-tree').setup({
  view = { width = 30 },
  renderer = { indent_markers = { enable = true } },
})
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
EOF

cat > $BASE/lua/plugins/git/gitsigns.lua <<'EOF'
require('gitsigns').setup({
  signs = { add = { text = '+' }, change = { text = '~' }, delete = { text = '_' } },
})
EOF

cat > $BASE/lua/plugins/editing/autopairs.lua <<'EOF'
require('nvim-autopairs').setup({})
EOF

cat > $BASE/lua/plugins/editing/comments.lua <<'EOF'
require('Comment').setup({})
EOF

# language stub
cat > $BASE/lua/plugins/languages/python.lua <<'EOF'
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function() vim.bo.shiftwidth = 4; vim.bo.tabstop = 4 end,
})
EOF

# after/plugin/example.lua
cat > $BASE/after/plugin/example.lua <<'EOF'
vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
EOF

echo "✅ Neovim lazy config installed at $BASE"
