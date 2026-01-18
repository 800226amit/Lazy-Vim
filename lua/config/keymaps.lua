local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
vim.g.mapleader = ' '
map('n', '<leader>w', ':w<CR>', default_opts)
map('n', '<leader>q', ':q<CR>', default_opts)
map('n', '<leader>p', ":Telescope find_files<CR>", default_opts)
