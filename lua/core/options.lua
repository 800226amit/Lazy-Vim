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

-- Cross-platform clipboard
-- Linux: needs xclip/xsel/wl-clipboard  |  Mac: auto (pbcopy)
-- Windows WSL: uses clip.exe + powershell  |  SSH: uses OSC52
if vim.fn.has("wsl") == 1 then
  -- Windows WSL clipboard via clip.exe
  vim.g.clipboard = {
    name  = "WslClipboard",
    copy  = { ["+"] = "clip.exe",  ["*"] = "clip.exe" },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
elseif os.getenv("SSH_TTY") ~= nil and vim.fn.has("unix") == 1 then
  -- SSH remote: use OSC52 (works in most modern terminals: iTerm2, Windows Terminal, etc.)
  vim.g.clipboard = {
    name  = "OSC52",
    copy  = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
else
  opt.clipboard = "unnamedplus"
end

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
