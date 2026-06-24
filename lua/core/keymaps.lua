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
map("n", "<Tab>",   ":bnext<CR>",     { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>x", ":bd<CR>",              { desc = "Close buffer" })
map("n", "<leader>X", ":%bd|e#|bd#<CR>",      { desc = "Close all but current" })

-- Jump to buffer by number (matches bufferline ordinal numbers)
map("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "Buffer 1" })
map("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "Buffer 2" })
map("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "Buffer 3" })
map("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "Buffer 4" })
map("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "Buffer 5" })
map("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", { desc = "Buffer 6" })
map("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", { desc = "Buffer 7" })
map("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", { desc = "Buffer 8" })
map("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", { desc = "Buffer 9" })

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==",        { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==",        { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv",   { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv",   { desc = "Move selection up" })

-- Duplicate line (like VS Code Shift+Alt+Down)
map("n", "<A-S-j>", "yyp",              { desc = "Duplicate line down" })
map("n", "<A-S-k>", "yyP",              { desc = "Duplicate line up" })
map("v", "<A-S-j>", "y'>p",            { desc = "Duplicate selection down" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Stay in indent mode
map("v", "<Tab>", ">gv", { desc = "Indent right" })
map("v", "<S-Tab>", "<gv", { desc = "Indent left" })

-- Better paste (visual mode - paste without overwriting clipboard)
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- VS Code-like copy/cut/paste
map("v", "<C-c>", '"+y',  { desc = "Copy to system clipboard" })
map("v", "<C-x>", '"+d',  { desc = "Cut to system clipboard" })
map("n", "<C-v>", '"+p',  { desc = "Paste from system clipboard" })
map("i", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Undo/Redo (normal + insert mode)
map("n", "<C-z>", "u",        { desc = "Undo" })
map("i", "<C-z>", "<C-o>u",   { desc = "Undo" })
map("n", "<C-y>", "<C-r>",    { desc = "Redo" })
map("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })

-- File explorer
map("n", "<leader>e",  ":NvimTreeToggle<CR>",   { desc = "Toggle file explorer" })
map("n", "<C-b>",      ":NvimTreeToggle<CR>",   { desc = "Toggle sidebar" })
-- Reveal current file in explorer (like VS Code's "Reveal in Explorer")
map("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = "Reveal file in explorer" })

-- Telescope
map("n", "<C-p>",      ":Telescope find_files<CR>",  { desc = "Find files" })
map("n", "<C-f>",      ":Telescope live_grep<CR>",   { desc = "Find in files" })
map("n", "<leader>fb", ":Telescope buffers<CR>",     { desc = "Find buffers" })
map("n", "<leader>fr", ":Telescope oldfiles<CR>",    { desc = "Recent files" })
map("n", "<leader>fc", ":Telescope commands<CR>",    { desc = "Commands" })
map("n", "<leader>fh", ":Telescope help_tags<CR>",   { desc = "Help tags" })
map("n", "<leader>fp", ":Telescope projects<CR>",    { desc = "Projects" })
map("n", "<leader>ff", ":Telescope find_files<CR>",  { desc = "Find files" })
-- Search inside a specific directory (type path, then search)
map("n", "<leader>fd", function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.input("Directory: ", vim.fn.expand("%:p:h") .. "/", "dir"),
  })
end, { desc = "Find files in directory" })
-- Search text inside a specific directory
map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep({
    search_dirs = { vim.fn.input("Directory: ", vim.fn.expand("%:p:h") .. "/", "dir") },
  })
end, { desc = "Grep in directory" })
-- Browse files like a file manager (telescope-file-browser)
map("n", "<leader>fe", function()
  require("telescope").extensions.file_browser.file_browser({
    path = vim.fn.expand("%:p:h"),
    select_buffer = true,
  })
end, { desc = "Browse files (file browser)" })


-- LSP navigation (Telescope-powered for better UI)
map("n", "gd", "<cmd>Telescope lsp_definitions<CR>",      { desc = "Go to definition" })
map("n", "gr", "<cmd>Telescope lsp_references<CR>",       { desc = "Find all references" })
map("n", "gi", "<cmd>Telescope lsp_implementations<CR>",  { desc = "Go to implementation" })
map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Go to type definition" })
map("n", "K",  vim.lsp.buf.hover,                         { desc = "Hover documentation" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>lf", function() require("conform").format() end, { desc = "Format code" })

-- Live-preview rename (inc-rename) — <F2> and <leader>rn
map("n", "<leader>rn", function() return ":IncRename " .. vim.fn.expand("<cword>") end,
  { expr = true, desc = "Rename symbol (live preview)" })
map("n", "<F2>", function() return ":IncRename " .. vim.fn.expand("<cword>") end,
  { expr = true, desc = "Rename (F2, live preview)" })

-- LSP extra shortcuts
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>",    { desc = "Document symbols" })
map("n", "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<CR>",   { desc = "Workspace symbols" })
map("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>",          { desc = "References" })
map("n", "<leader>la", "<cmd>Telescope aerial<CR>",                  { desc = "Code outline (aerial)" })

-- Ctrl+Click → go to definition
map("n", "<C-LeftMouse>", "<LeftMouse><cmd>Telescope lsp_definitions<CR>", { desc = "Go to definition (click)" })

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

-- ── Harpoon 2 ─────────────────────────────────────────────────────────────
-- <leader>ha → mark current file
-- <leader>hh → open harpoon list (pick with telescope)
-- <C-1>..<C-4> → instantly jump to marked file 1-4
map("n", "<leader>ha", function() require("harpoon"):list():add() end,
  { desc = "Harpoon: mark file" })
map("n", "<leader>hh", function()
  _G._harpoon_telescope(require("harpoon"):list())
end, { desc = "Harpoon: pick file (telescope)" })
map("n", "<leader>hm", function()
  local harpoon = require("harpoon")
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: quick menu" })
map("n", "<C-1>", function() require("harpoon"):list():select(1) end, { desc = "Harpoon file 1" })
map("n", "<C-2>", function() require("harpoon"):list():select(2) end, { desc = "Harpoon file 2" })
map("n", "<C-3>", function() require("harpoon"):list():select(3) end, { desc = "Harpoon file 3" })
map("n", "<C-4>", function() require("harpoon"):list():select(4) end, { desc = "Harpoon file 4" })
-- Harpoon prev/next (<C-S-P>/<C-S-N> terminals mein kaam nahi karte)
map("n", "<leader>hp", function() require("harpoon"):list():prev() end, { desc = "Harpoon: prev file" })
map("n", "<leader>hn", function() require("harpoon"):list():next() end, { desc = "Harpoon: next file" })

-- ── Aerial (code outline) ──────────────────────────────────────────────────
map("n", "<leader>ao", "<cmd>AerialToggle<CR>",  { desc = "Aerial: toggle outline" })
map("n", "<leader>an", "<cmd>AerialNext<CR>",    { desc = "Aerial: next symbol" })
map("n", "<leader>ap", "<cmd>AerialPrev<CR>",    { desc = "Aerial: prev symbol" })

-- ── Spectre (project-wide search & replace) ───────────────────────────────
map("n", "<leader>sr",  function() require("spectre").open() end,
  { desc = "Spectre: open search/replace" })
map("n", "<leader>sw",  function() require("spectre").open_visual({ select_word = true }) end,
  { desc = "Spectre: replace word under cursor" })
map("v", "<leader>sw",  function() require("spectre").open_visual() end,
  { desc = "Spectre: replace selection" })
map("n", "<leader>sf",  function() require("spectre").open_file_search() end,
  { desc = "Spectre: search in current file" })

-- ── Diffview (git diff & history) ─────────────────────────────────────────
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>",          { desc = "Git: open diff view" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Git: current file history" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>",   { desc = "Git: project history" })
map("n", "<leader>gc", "<cmd>DiffviewClose<CR>",         { desc = "Git: close diff view" })
