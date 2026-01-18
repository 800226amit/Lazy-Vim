-- =============================================
-- UI Configuration - Enhanced Visual Experience
-- =============================================

-- LSP configuration for better diagnostics
vim.diagnostic.config({
  virtual_text = {
    enabled = true,
    source = "if_many",
    prefix = "●",
    spacing = 4,
    format = function(diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        return string.format("󰅚 %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.WARN then
        return string.format("󰀪 %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        return string.format(" %s", diagnostic.message)
      elseif diagnostic.severity == vim.diagnostic.severity.HINT then
        return string.format("󰌶 %s", diagnostic.message)
      end
      return diagnostic.message
    end,
  },
  signs = {
    priority = 20,
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    format = function(diagnostic)
      return string.format("%s (%s)", diagnostic.message, diagnostic.source)
    end,
  },
})

-- Define diagnostic signs with better icons
local signs = {
  Error = "󰅚",
  Warn = "󰀪",
  Hint = "󰌶",
  Info = ""
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Enhanced completion menu appearance
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

-- Custom highlight groups for better visual feedback
local function set_highlights()
  -- Better visual selection
  vim.api.nvim_set_hl(0, "Visual", { bg = "#264F78" })
  
  -- Better search highlighting
  vim.api.nvim_set_hl(0, "Search", { bg = "#613315", fg = "#FFFFFF" })
  vim.api.nvim_set_hl(0, "IncSearch", { bg = "#FF8C00", fg = "#000000" })
  
  -- Better cursor line
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2A2A2A" })
  
  -- Better line numbers
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#5A5A5A" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFF00", bold = true })
  
  -- Better fold styling
  vim.api.nvim_set_hl(0, "Folded", { bg = "#202020", fg = "#808080", italic = true })
  vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE", fg = "#404040" })
  
  -- Better diff highlighting
  vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#003300" })
  vim.api.nvim_set_hl(0, "DiffChange", { bg = "#333300" })
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#330000" })
  vim.api.nvim_set_hl(0, "DiffText", { bg = "#555500" })
end

-- Apply highlights after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_highlights,
})

-- Apply highlights on startup
set_highlights()

-- Better window borders
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#79DACE", bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1E1E2E" })

-- Statusline enhancements
vim.o.laststatus = 3 -- Global statusline
vim.o.showtabline = 2 -- Always show tabline

-- Better command line
vim.o.cmdheight = 1
vim.o.showcmd = true
vim.o.showmode = false

-- Enhanced visual feedback
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes:2"
vim.o.colorcolumn = "80,120"

-- Smooth scrolling and better visual experience
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.wrap = false
vim.o.linebreak = true
vim.o.breakindent = true

-- Better split separators
vim.o.fillchars = "vert:│,horiz:─,horizup:┴,horizdown:┬,vertleft:┤,vertright:├,verthoriz:┼"

-- Enable 24-bit RGB colors
vim.o.termguicolors = true

-- Cursor styling
vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Better popup menu
vim.o.pumblend = 10
vim.o.winblend = 10

-- Title and icon
vim.o.title = true
vim.o.titlestring = "%<%F%=%l/%L - nvim"

-- Message display
vim.o.shortmess = "atOIcF"

-- Update time for better responsiveness
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Better concealing
vim.o.conceallevel = 2
vim.o.concealcursor = "nc"