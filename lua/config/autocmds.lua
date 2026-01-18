-- =============================================
-- Auto Commands - Smart Behaviors
-- =============================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ===== GENERAL EDITOR BEHAVIORS =====

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Search", timeout = 300 })
  end,
})

-- Auto-reload files when they change externally (like VS Code)
autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  group = augroup("AutoReload", { clear = true }),
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Auto-save files when leaving insert mode or text changes
autocmd({ "InsertLeave", "TextChanged" }, {
  group = augroup("AutoSave", { clear = true }),
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command("silent write")
    end
  end,
})

-- ===== SMART LINE NUMBERS =====
local line_numbers_group = augroup("LineNumbers", { clear = true })

-- Show relative line numbers in normal mode, absolute in insert mode
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = line_numbers_group,
  callback = function()
    if vim.opt.number:get() and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = line_numbers_group,
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
    end
  end,
})

-- ===== TERMINAL ENHANCEMENTS =====
autocmd("TermOpen", {
  group = augroup("TerminalSettings", { clear = true }),
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
})

-- Auto close terminal when process exits
autocmd("TermClose", {
  group = augroup("TerminalAutoClose", { clear = true }),
  callback = function()
    vim.cmd("bd!")
  end,
})

-- ===== FILE TYPE SPECIFIC SETTINGS =====

-- Enable spell checking for markdown and text files
autocmd("FileType", {
  group = augroup("SpellCheck", { clear = true }),
  pattern = { "markdown", "text", "gitcommit", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

-- Java specific settings
autocmd("FileType", {
  group = augroup("JavaSettings", { clear = true }),
  pattern = { "java" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.colorcolumn = "100,120"
    -- Enable method signatures help
    vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, { buffer = 0, desc = "Signature help" })
  end,
})

-- JavaScript/TypeScript specific settings
autocmd("FileType", {
  group = augroup("JSSettings", { clear = true }),
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.colorcolumn = "80,100"
  end,
})

-- Python specific settings
autocmd("FileType", {
  group = augroup("PythonSettings", { clear = true }),
  pattern = { "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.colorcolumn = "88,120"
  end,
})

-- JSON/YAML formatting
autocmd("FileType", {
  group = augroup("DataFormats", { clear = true }),
  pattern = { "json", "yaml", "yml" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- ===== AUTO FORMATTING =====
autocmd("BufWritePre", {
  group = augroup("AutoFormat", { clear = true }),
  pattern = { 
    "*.lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx", 
    "*.css", "*.html", "*.json", "*.yaml", "*.yml", 
    "*.md", "*.java", "*.go", "*.rs" 
  },
  callback = function()
    require("conform").format({ timeout_ms = 1000, lsp_fallback = true })
  end,
})

-- ===== WINDOW MANAGEMENT =====

-- Auto resize splits when window is resized
autocmd("VimResized", {
  group = augroup("ResizeSplits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Remember cursor position
autocmd("BufReadPost", {
  group = augroup("RestoreCursor", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ===== PROJECT MANAGEMENT =====

-- Auto-detect project root and set working directory
autocmd("VimEnter", {
  group = augroup("ProjectRoot", { clear = true }),
  callback = function()
    local function find_project_root()
      local markers = { ".git", "package.json", "pom.xml", "build.gradle", "Cargo.toml", "go.mod" }
      local path = vim.fn.expand("%:p:h")
      
      while path ~= "/" do
        for _, marker in ipairs(markers) do
          if vim.fn.filereadable(path .. "/" .. marker) == 1 or vim.fn.isdirectory(path .. "/" .. marker) == 1 then
            return path
          end
        end
        path = vim.fn.fnamemodify(path, ":h")
      end
      return vim.fn.getcwd()
    end
    
    local root = find_project_root()
    if root ~= vim.fn.getcwd() then
      vim.cmd("cd " .. root)
    end
  end,
})

-- ===== ENHANCED FILE OPERATIONS =====

-- Auto-create directories for new files
autocmd("BufWritePre", {
  group = augroup("AutoMkdir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Auto-create directories for undo files
autocmd("VimEnter", {
  group = augroup("CreateUndoDir", { clear = true }),
  callback = function()
    local undodir = vim.fn.stdpath("data") .. "/undodir"
    if vim.fn.isdirectory(undodir) == 0 then
      vim.fn.mkdir(undodir, "p")
    end
  end,
})

-- ===== SMART BEHAVIORS =====

-- Close certain filetypes with q
autocmd("FileType", {
  group = augroup("CloseWithQ", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "trouble",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Disable diagnostics in node_modules
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("DisableDiagnosticsNodeModules", { clear = true }),
  pattern = "*/node_modules/*",
  callback = function()
    vim.diagnostic.disable(0)
  end,
})

-- ===== FRAMEWORK SPECIFIC AUTOCMDS =====

-- Spring Boot application.properties/yml syntax
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("SpringBootConfig", { clear = true }),
  pattern = { "application*.properties", "application*.yml", "application*.yaml" },
  callback = function()
    vim.bo.filetype = "properties"
    -- Enable auto-completion for Spring Boot properties
    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})

-- Docker files
autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("DockerFiles", { clear = true }),
  pattern = { "Dockerfile*", "*.dockerfile" },
  callback = function()
    vim.bo.filetype = "dockerfile"
  end,
})

-- React/Next.js specific settings
autocmd("FileType", {
  group = augroup("ReactSettings", { clear = true }),
  pattern = { "javascriptreact", "typescriptreact" },
  callback = function()
    -- Enable JSX syntax highlighting
    vim.opt_local.syntax = "javascript.jsx"
    -- Set up specific keymaps for React development
    vim.keymap.set("n", "<leader>rc", ":!npx create-react-app ", { buffer = 0, desc = "Create React App" })
    vim.keymap.set("n", "<leader>rn", ":!npx create-next-app ", { buffer = 0, desc = "Create Next.js App" })
  end,
})

-- ===== PERFORMANCE OPTIMIZATIONS =====

-- Disable certain features for large files
autocmd("BufRead", {
  group = augroup("LargeFile", { clear = true }),
  callback = function()
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
    if ok and stats and stats.size > max_filesize then
      vim.opt_local.syntax = ""
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.spell = false
      vim.opt_local.foldmethod = "manual"
      vim.cmd("TSBufDisable highlight")
      vim.cmd("TSBufDisable incremental_selection")
      vim.cmd("TSBufDisable textobjects")
    end
  end,
})

-- ===== PLUGIN INTEGRATION =====

-- Auto-open nvim-tree if no file is specified
autocmd("VimEnter", {
  group = augroup("AutoOpenTree", { clear = true }),
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("NvimTreeOpen")
    end
  end,
})

-- Close nvim-tree if it's the last window
autocmd("BufEnter", {
  group = augroup("NvimTreeClose", { clear = true }),
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then
      vim.cmd("confirm quit")
    end
  end,
})