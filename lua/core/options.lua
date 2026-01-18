-- =============================================
-- Editor Options - Best Settings for Coding
-- =============================================

local opt = vim.opt

-- UI Settings
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.termguicolors = true
opt.showmode = false
opt.cmdheight = 1
opt.pumheight = 10
opt.pumblend = 10

-- Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Behavior
opt.scrolloff = 8
opt.updatetime = 50
opt.timeoutlen = 300
opt.mouse = "a"
opt.clipboard = "unnamedplus"

-- Folding (better with Treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldenable = false

-- Whitespace
opt.list = true
opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "␣"
}

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Performance
opt.lazyredraw = false
opt.synmaxcol = 240
