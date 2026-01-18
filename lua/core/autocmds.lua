-- =============================================
-- Auto Commands - Smart Automation
-- =============================================

local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
  desc = "Highlight yanked text"
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
  desc = "Remove trailing whitespace"
})

-- Auto create parent directories
autocmd("BufWritePre", {
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Auto create directories"
})

-- Terminal settings
autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
  desc = "Terminal options"
})

-- Close certain filetypes with 'q'
autocmd("FileType", {
  pattern = { "qf", "help", "man", "notify", "lspinfo", "spectre_panel" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Close window"
    })
  end,
  desc = "Close with q"
})

-- Check if file changed outside Neovim
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  command = "checktime",
  desc = "Check for file changes"
})

-- Resize splits on window resize
autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Resize splits"
})

-- Go to last location when opening buffer
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last location"
})
