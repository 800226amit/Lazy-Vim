-- =============================================
-- Keymaps - VS Code-like shortcuts + Vim power
-- =============================================

local map = vim.keymap.set

-- Better save/quit
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })
map("n", "<C-q>", ":q<CR>", { desc = "Quit" })

-- Clear search highlight
map("n", "<Esc>", ":noh<CR>", { desc = "Clear search" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease height" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- Split windows
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal splits" })
map("n", "<leader>sx", ":close<CR>", { desc = "Close split" })

-- Buffer navigation
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>x", ":bd<CR>", { desc = "Close buffer" })
map("n", "<leader>X", ":%bd|e#|bd#<CR>", { desc = "Close all but current" })

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Stay in indent mode
map("v", "<Tab>", ">gv", { desc = "Indent right" })
map("v", "<S-Tab>", "<gv", { desc = "Indent left" })

-- Better paste
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Undo/Redo
map("n", "<C-z>", "u", { desc = "Undo" })
map("n", "<C-y>", "<C-r>", { desc = "Redo" })

-- File explorer
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<C-b>", ":NvimTreeToggle<CR>", { desc = "Toggle sidebar" })

-- Telescope
map("n", "<C-p>", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<C-f>", ":Telescope live_grep<CR>", { desc = "Find in files" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>fc", ":Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fp", ":Telescope projects<CR>", { desc = "Projects" })

-- LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename (F2)" })
map("n", "<leader>f", function() require("conform").format() end, { desc = "Format code" })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

-- Git
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })
map("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git blame" })
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map("n", "]c", ":Gitsigns next_hunk<CR>", { desc = "Next hunk" })
map("n", "[c", ":Gitsigns prev_hunk<CR>", { desc = "Previous hunk" })

-- Terminal
map("n", "<C-\\>", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Trouble (diagnostics)
map("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", { desc = "Toggle diagnostics" })
map("n", "<leader>xd", ":Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer diagnostics" })

-- Comment
map("n", "<C-/>", "gcc", { remap = true, desc = "Comment line" })
map("v", "<C-/>", "gc", { remap = true, desc = "Comment selection" })

-- Zen mode
map("n", "<leader>z", ":ZenMode<CR>", { desc = "Zen mode" })

-- UndoTree
map("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle undo tree" })

-- Session
map("n", "<leader>ss", function() require("persistence").load() end, { desc = "Restore session" })
map("n", "<leader>sl", function() require("persistence").load({ last = true }) end, { desc = "Last session" })

-- Markdown preview
map("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown preview" })
