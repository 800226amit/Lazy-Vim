# Ultimate Neovim Config — Complete Shortcut Guide

**Leader key = `Space`**  `jk` ya `jj` se Insert mode se bahar nikalein

---

## Shortcuts kaise dabate hain — Basic Rules

| Likha hai | Matlab | Keyboard pe kya karo |
|-----------|--------|----------------------|
| `Ctrl+S` | Ctrl aur S | `Ctrl` dabo rakho → `s` dabao → chhhodo |
| `Ctrl+V` (V capital) | Sirf Ctrl+v | Shift NAHI dabaana — V capital sirf padhne ke liye |
| `Shift+V` | Shift aur V | `Shift` dabo rakho → `v` dabao |
| `Shift+Tab` | Shift aur Tab | `Shift` dabo rakho → `Tab` dabao |
| `Alt+J` | Alt aur j | `Alt` dabo rakho → `j` dabao |
| `Alt+Shift+J` | Alt+Shift+j | `Alt` + `Shift` dono dabo rakho → `j` dabao |
| `Space+gd` | Leader phir gd | `Space` chhhodo → `g` dabao → `d` dabao |

> **Note**: `Ctrl+Shift+Letter` Linux terminal mein reliable nahi hota — isliye is config mein aisi shortcuts nahi hain.

---

---

## Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| **Linux** | Full | `sudo apt install ripgrep fd-find xclip` |
| **Mac** | Full | `brew install ripgrep fd lazygit neovim` — clipboard auto (pbcopy) |
| **Windows WSL** | Full | clipboard auto-config via `clip.exe` |
| **Windows Native** | Partial | telescope-fzf needs MSVC/MinGW; baki sab kaam karta |
| **SSH Remote** | Full | clipboard via OSC52 (iTerm2 / Windows Terminal mein kaam karta) |

### Mac pe kya install karein
```bash
brew install neovim ripgrep fd lazygit
brew install --cask font-jetbrains-mono-nerd-font
xcode-select --install   # telescope-fzf-native ke liye
```

### Windows WSL pe kya install karein
```bash
sudo apt install ripgrep fd-find xclip
# clipboard WSL config auto-detect hoti hai (clip.exe use karta hai)
```

### SSH pe clipboard
OSC52 protocol auto-use hota hai. Terminal mein enable karein:
- **iTerm2**: Settings → General → Selection → Enable OSC52
- **Windows Terminal**: Auto-supported
- **tmux**: `set -s set-clipboard on` in `~/.tmux.conf`

---

## Text Select Karna, Delete Karna, Copy Karna

### VS Code se compare karein

| VS Code | Neovim | Kya karta hai |
|---------|--------|--------------|
| Click+Drag | `v` phir `h/l/j/k` | Characters select karo |
| Ctrl+L (line) | `V` (Shift+V) | Puri line select karo |
| Ctrl+D | `viw` | Ek word select karo |
| Double-click word | `viw` | Word select (inner) |
| Ctrl+Shift+K (delete line) | `dd` | Line delete karo |
| Ctrl+X (cut line) | `dd` (clipboard se jaata hai) | Line cut karo |
| Backspace | `x` | Ek character delete karo |
| Ctrl+Backspace | `diw` | Ek word delete karo |
| Ctrl+Shift+D (duplicate) | `Alt+Shift+J` | Line duplicate karo |

### Character (ek ek letter)

| Key | Action |
|-----|--------|
| `v` | Visual mode shuru karo — phir arrows se select badao |
| `x` | Cursor pe character delete karo |
| `r` + letter | Cursor pe character replace karo |
| `~` | Cursor pe letter ka case badlo (upper → lower) |

### Word (ek shabd)

| Key | Action |
|-----|--------|
| `viw` | Inner word select (spaces nahi) |
| `vaw` | Around word select (spaces sahit) |
| `yiw` | Word copy (yank) |
| `diw` | Word delete |
| `ciw` | Word change (delete + insert mode) |
| `dw` | Word se aage tak delete karo |

### Line (puri line)

| Key | Action |
|-----|--------|
| `V` (Shift+V) | Puri line select karo |
| `yy` | Puri line copy karo |
| `dd` | Puri line delete karo |
| `cc` ya `S` | Puri line change karo (delete + insert) |
| `D` | Cursor se line end tak delete karo |
| `C` | Cursor se line end tak change karo |

### Multiple lines

| Key | Action |
|-----|--------|
| `V` phir `j/k` | Multiple lines select karo |
| `3yy` | 3 lines copy karo |
| `3dd` | 3 lines delete karo |
| `Ctrl+d` | Next matching word select (multi-cursor) |

### VS Code-style shortcuts (custom)

| Key | Action |
|-----|--------|
| `Ctrl+C` | Copy (visual mode) |
| `Ctrl+X` | Cut (visual mode) |
| `Ctrl+V` | Paste (normal/insert mode) |
| `Ctrl+Z` | Undo |
| `Ctrl+Y` | Redo |
| `Ctrl+A` | Select all |
| `Alt+J` | Line neeche move karo |
| `Alt+K` | Line upar move karo |
| `Alt+Shift+J` | Line duplicate karo (neeche) — Alt dabo + Shift dabo + j dabao |
| `Alt+Shift+K` | Line duplicate karo (upar)  — Alt dabo + Shift dabo + k dabao |

---

## File Explorer (NvimTree)

### Open/Close

| Key | Action |
|-----|--------|
| `Ctrl+B` | File explorer toggle karo |
| `Space+e` | File explorer toggle karo |
| `Space+ef` | **Current file ko explorer mein dikhao** (VS Code "Reveal in Explorer") |

### Explorer aur File ke beech jaana

```
EDITOR ──→ EXPLORER:  Ctrl+H  (left window)
EXPLORER ──→ EDITOR:  Ctrl+L  (right window)
```

Ya simple tarika:
- `Space+ef` → current file explorer mein show ho jaata hai
- File pe Enter dabao → file open, cursor editor mein
- `Ctrl+H` / `Ctrl+L` se switch karo

### Explorer ke andar shortcuts

| Key | Action |
|-----|--------|
| `Enter` ya `l` | File open / folder expand karo |
| `h` | Folder collapse karo |
| `a` | Naya file/folder banao (naam type karo) |
| `d` | Delete karo |
| `r` | Rename karo |
| `x` | Cut karo |
| `c` | Copy karo |
| `p` | Paste karo |
| `y` | File naam copy karo |
| `Y` | Relative path copy karo |
| `gy` | Full path copy karo |
| `R` | Tree refresh karo |
| `H` | Hidden files dikhao/chhupao |
| `q` | Explorer band karo |
| `?` | Saari shortcuts dikhao |

---

## File Dhundna (Telescope)

### Files dhundna

| Key | Action |
|-----|--------|
| `Ctrl+P` | Files dhundo (poore project mein) |
| `Space+ff` | Files dhundo |
| `Space+fr` | Recently opened files |
| `Space+fb` | Open buffers (tabs) |
| `Space+fe` | **File browser** (folder tree, directory navigate karo) |
| `Space+fd` | **Kisi specific directory mein files dhundo** |
| `Space+fg` | **Kisi specific directory mein text dhundo** |

### Text dhundna

| Key | Action |
|-----|--------|
| `Ctrl+F` | Poore project mein text dhundo (live grep) |
| `Space+fg` | Directory choose kar ke text dhundo |

### Telescope ke andar shortcuts

| Key | Action |
|-----|--------|
| `Ctrl+J` ya Down | Next item |
| `Ctrl+K` ya Up | Previous item |
| `Enter` | File open karo |
| `Ctrl+V` | Vertical split mein open karo |
| `Ctrl+X` | Horizontal split mein open karo |
| `Esc` | Telescope band karo |

---

## Code Navigation (VS Code Ctrl+Click jaisa)

| Key | Action |
|-----|--------|
| `Ctrl+Click` | **Go to Definition** (mouse click) |
| `gd` | **Go to Definition** (keyboard) |
| `gr` | **Find all References** — method/variable kahan kahan use ho raha hai |
| `gi` | Go to Implementation |
| `gt` | Go to Type Definition |
| `K` | Documentation popup dikhao (hover) |
| `[d` | Previous error/warning |
| `]d` | Next error/warning |
| `Space+d` | Current line ki diagnostic dikhao |

### LSP shortcuts

| Key | Action |
|-----|--------|
| `Space+lr` | References list (Telescope mein) |
| `Space+ls` | File ke saare symbols (functions, classes) |
| `Space+lw` | Poore project ke symbols dhundo |
| `Space+la` | **Code outline** (Aerial — sidebar mein function tree) |
| `Space+rn` ya `F2` | **Rename** (live preview ke saath) |
| `Space+ca` | Code action (quick fix, import, etc.) |
| `Space+lf` | **Format code** |

---

## Harpoon — Instant File Jump (Mouse-free)

Files pin karo, instantly unpe jaao bina kuch dhunde.

| Key | Action |
|-----|--------|
| `Space+ha` | **Current file mark karo** (pin karo) |
| `Space+hm` | Harpoon quick menu (marked files list) |
| `Space+hh` | Telescope mein harpoon list |
| `Ctrl+1` | Pehli marked file pe jaao |
| `Ctrl+2` | Doosri marked file pe jaao |
| `Ctrl+3` | Teesri marked file pe jaao |
| `Ctrl+4` | Chauthi marked file pe jaao |
| `Space+hp` | Harpoon list mein previous file |
| `Space+hn` | Harpoon list mein next file |

**Workflow**: `Space+ha` se 4 files mark karo, phir `Ctrl+1/2/3/4` se instantly switch karo.

---

## Code Outline — Aerial

Function/class tree keyboard se navigate karo.

| Key | Action |
|-----|--------|
| `Space+ao` | Aerial outline toggle karo |
| `Space+an` | Next function/class pe jaao |
| `Space+ap` | Previous function/class pe jaao |
| `Space+la` | Telescope mein aerial symbols search karo |

---

## Search & Replace — Project-Wide (Spectre)

| Key | Action |
|-----|--------|
| `Space+sr` | Spectre open karo (poore project mein replace) |
| `Space+sw` | Word under cursor replace karo (project-wide) |
| `Space+sf` | Sirf current file mein search/replace |

---

## Git

| Key | Action |
|-----|--------|
| `Space+gg` | **LazyGit** (full git UI) |
| `Space+gd` | **Git diff** (side-by-side) |
| `Space+gh` | Current file ki git history |
| `Space+gH` | Poore project ki git history |
| `Space+gc` | Diff view band karo |
| `Space+gb` | Line ka git blame dikhao |
| `Space+gp` | Hunk preview |
| `Space+gs` | Hunk stage karo |
| `Space+gr` | Hunk reset karo |
| `]c` | Next git change |
| `[c` | Previous git change |

---

## Buffers (Open Files / Tabs)

| Key | Action |
|-----|--------|
| `Tab` | Next buffer |
| `Shift+Tab` | Previous buffer |
| `Space+1` — `Space+9` | **Buffer number se seedha jaao** (tab bar ke number se) |
| `Space+x` | Current buffer band karo |
| `Space+X` | Sab buffer band karo (current chhod ke) |
| `Space+fb` | Buffer list (Telescope mein) |

---

## Window Management

### Split karo

| Key | Action |
|-----|--------|
| `Space+sv` | Vertical split |
| `Space+sh` | Horizontal split |
| `Space+se` | Splits barabar karo |
| `Space+sx` | Split band karo |

### Windows ke beech navigate karo

| Key | Action |
|-----|--------|
| `Ctrl+H` | Left window |
| `Ctrl+L` | Right window |
| `Ctrl+J` | Neeche wala window |
| `Ctrl+K` | Upar wala window |

### Resize karo

| Key | Action |
|-----|--------|
| `Ctrl+Up` | Height kam karo |
| `Ctrl+Down` | Height badao |
| `Ctrl+Left` | Width kam karo |
| `Ctrl+Right` | Width badao |

---

## Terminal

| Key | Action |
|-----|--------|
| `Ctrl+\` | Terminal toggle karo (floating) |
| `Esc` | Terminal se normal mode |
| `i` | Terminal mein wapas type karo |

---

## Search (File ke andar)

| Key | Action |
|-----|--------|
| `/text` | Aage dhundo |
| `?text` | Peeche dhundo |
| `n` | Next match |
| `N` | Previous match |
| `Esc` | Search highlight hatao |
| `*` | Word under cursor dhundo (aage) |
| `#` | Word under cursor dhundo (peeche) |

---

## Comments, Indent, Surround

| Key | Action |
|-----|--------|
| `Ctrl+/` | Line comment toggle |
| `gcc` | Line comment toggle |
| `gc` | Selection comment toggle (visual mode) |
| `>` | Right indent (visual mode) |
| `<` | Left indent (visual mode) |
| `Tab` | Right indent (visual mode) |
| `ys{motion}{char}` | Surround add karo (`ysiw"` → word ke around `"`) |
| `ds{char}` | Surround hatao (`ds"` → `"` hata do) |
| `cs{old}{new}` | Surround badlo (`cs"'` → `"` ko `'` se badlo) |

---

## Jump / Flash Navigation

| Key | Action |
|-----|--------|
| `s` | Flash jump — 2 characters type karo, kisi bhi jagah jump karo |
| `S` | Flash treesitter — code structure se jump karo |

---

## Completion (Insert Mode)

| Key | Action |
|-----|--------|
| `Ctrl+Space` | Completion trigger karo |
| `Tab` | Next suggestion |
| `Shift+Tab` | Previous suggestion |
| `Enter` | Suggestion confirm karo |
| `Ctrl+E` | Completion band karo |

---

## Diagnostics / Errors

| Key | Action |
|-----|--------|
| `Space+xx` | Errors panel toggle karo |
| `Space+xd` | Current file errors panel |
| `[d` | Previous error |
| `]d` | Next error |
| `Space+d` | Error popup (current line) |
| `Space+q` | Error list (quickfix) |

---

## Undo Tree, Sessions, Zen

| Key | Action |
|-----|--------|
| `Space+u` | Undo tree dikhao (visual undo history) |
| `Space+ss` | Session restore karo |
| `Space+sl` | Last session restore karo |
| `Space+z` | Zen mode (distraction-free) |
| `Space+mp` | Markdown preview |

---

## File Operations

| Key | Action |
|-----|--------|
| `Ctrl+S` | Save |
| `Ctrl+S` (insert) | Save (insert mode mein bhi) |
| `Ctrl+Q` | Quit |
| `:wq` | Save aur quit |
| `:q!` | Bina save ke quit |

---

## Modes Quick Reference

| Key | Mode |
|-----|------|
| `i` | Insert (cursor ke pehle) |
| `a` | Insert (cursor ke baad) |
| `I` | Insert (line ke shuru) |
| `A` | Insert (line ke ant) |
| `o` | Insert (neeche nai line) |
| `O` | Insert (upar nai line) |
| `v` | Visual (character) |
| `V` | Visual (line) |
| `Ctrl+V` | Visual (block/column) |
| `jk` ya `jj` | Insert → Normal |
| `Esc` | Kisi bhi mode → Normal |

---

## Kya Linux/Mac/Windows pe kaam karta hai

| Feature | Linux | Mac | WSL | Windows Native | SSH |
|---------|-------|-----|-----|----------------|-----|
| Clipboard | ✅ xclip | ✅ pbcopy | ✅ clip.exe | ✅ native | ✅ OSC52 |
| LazyGit | ✅ | ✅ | ✅ | ✅ | ✅ |
| Telescope fzf | ✅ | ✅ | ✅ | ⚠️ needs make | ✅ |
| LuaSnip jsregexp | ✅ | ✅ | ✅ | ⚠️ needs MinGW | ✅ |
| Markdown Preview | ✅ | ✅ | ✅ | ✅ | ❌ browser needed |
| Terminal (ToggleTerm) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Mouse support | ✅ | ✅ | ✅ | ✅ | ⚠️ terminal-dependent |
| Fonts (Nerd Fonts) | ✅ | ✅ | ✅ | ✅ | ⚠️ terminal pe set karein |

### Windows Native — Kya nahi kaam karta
- `telescope-fzf-native`: build ke liye `make` chahiye → `winget install GnuWin32.Make`
- Shell-based tools (jo Linux commands use karte hain) nahi chalenge
- Workaround: **WSL use karo** — sab kuch perfectly kaam karta hai

### Mac — Sab kaam karta hai, bas install karo
```bash
brew install neovim ripgrep fd lazygit
xcode-select --install
```

---

## Which-Key — Shortcuts bhool gaye?

`Space` dabao aur ruko — saari available shortcuts ka popup aayega!

---

## Help Commands

| Command | Kya karta hai |
|---------|---------------|
| `:Lazy` | Plugin manager |
| `:Lazy sync` | Plugins update karo |
| `:Mason` | LSP server install/manage karo |
| `:checkhealth` | Neovim health check |
| `:LspInfo` | LSP status dekho |
| `:Telescope keymaps` | Saari shortcuts search karo |
| `:ConformInfo` | Formatter status |

---

## File Structure

```
~/.config/nvim/
├── init.lua
└── lua/
    ├── core/
    │   ├── options.lua      # Editor settings (clipboard, tabs, etc.)
    │   ├── keymaps.lua      # Saare shortcuts
    │   └── autocmds.lua     # Auto commands
    └── plugins/
        ├── lazy-setup.lua   # Plugin manager
        ├── lsp.lua          # Language servers
        ├── completion.lua   # Auto-complete
        ├── treesitter.lua   # Syntax highlight
        ├── ui.lua           # Theme, lualine, which-key, noice
        ├── telescope.lua    # File finder + file browser
        ├── git.lua          # Git (gitsigns, lazygit, diffview)
        ├── editor.lua       # Aerial, Spectre, inc-rename, autotag
        ├── coding.lua       # autopairs, surround, formatter
        └── harpoon.lua      # Harpoon 2 — instant file jump
```
