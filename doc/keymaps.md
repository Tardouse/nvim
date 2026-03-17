# Neovim Keymaps Reference

> Leader key: `<Space>`

## Table of Contents

- [Global Keymaps](#global-keymaps)
- [Buffer Management](#buffer-management)
- [LSP](#lsp)
- [Search & Navigation](#search--navigation)
- [Git](#git)
- [Debugger](#debugger)
- [File Explorer](#file-explorer)
- [Editing](#editing)
- [Markdown](#markdown)
- [Miscellaneous](#miscellaneous)

---

## Global Keymaps

| Key | Mode | Description |
|-----|------|-------------|
| `<Esc>` | Normal | Clear search highlight |
| `\\w` | Normal | Print full path of current file |
| `<C-t>` | Normal | Toggle NERDTree |
| `<C-j>` | Normal | Insert line below (paste mode) |
| `<leader>dg` | Normal | diffget |
| `<leader>dp` | Normal | diffput |

## Buffer Management

| Key | Mode | Description |
|-----|------|-------------|
| `tp` | Normal | Previous buffer |
| `tn` | Normal | Next buffer |
| `td` | Normal | Delete current buffer |

---

## LSP

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>hd` | Normal | Show hover documentation |
| `<C-l>` | Normal | Go to definition |
| `<leader>hi` | Normal | Go to implementation |
| `<leader>ho` | Normal | Go to type definition |
| `<leader>hr` | Normal | Show references |
| `<M-f>` | Insert | Show signature help |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>aw` | Normal | Code action menu |
| `<leader>ht` | Normal | Toggle Trouble diagnostics |
| `<leader>-` | Normal | Go to previous diagnostic |
| `<leader>=` | Normal | Go to next diagnostic |

---

## Search & Navigation

### Telescope

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>tf` | Normal | Find files |
| `<leader>rs` | Normal | Resume last search |
| `<leader>tb` | Normal | List buffers |
| `<leader>to` | Normal | Old files (recent) |
| `<leader>tz` | Normal | Fuzzy find in current buffer |
| `<leader>td` | Normal | Diagnostics |
| `<leader>tg` | Normal | Git status |
| `<leader>t.` | Normal | Commands |

**Telescope Insert Mode:**

| Key | Description |
|-----|-------------|
| `<C-h>` | Show which_key help |
| `<C-j>` | Move selection next |
| `<C-k>` | Move selection previous |
| `<C-f>` | Preview scroll up |
| `<C-b>` | Preview scroll down |
| `<C-n>` | Cycle history next |
| `<C-p>` | Cycle history prev |
| `<C-d>` | Delete buffer (in buffers picker) |

### FZF

| Key | Mode | Description |
|-----|------|-------------|
| `<C-f>` | Normal | Grep search |
| `<C-f>` | Visual | Grep visual selection |

**FZF Built-in:**

| Key | Description |
|-----|-------------|
| `<C-f>` | Toggle fullscreen |
| `<C-r>` | Toggle preview wrap |
| `<C-p>` | Toggle preview |
| `<C-n>` | Preview page down |
| `<C-u>` | Preview page up |
| `<S-left>` | Preview page reset |
| `Esc` | Abort |
| `Ctrl-j` | Down |
| `Ctrl-k` | Up |

### Flash (Motion)

| Key | Mode | Description |
|-----|------|-------------|
| `f` | Normal/Visual/Operator | Flash jump |
| `F` | Normal/Visual/Operator | Flash Treesitter |
| `r` | Operator | Remote Flash |
| `R` | Operator/Visual | Treesitter Search |
| `<C-s>` | Command | Toggle Flash Search |

### Commander

| Key | Mode | Description |
|-----|------|-------------|
| `<C-q>` | Normal | Open command palette |

### Tagbar

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>t8` | Normal | Toggle Tagbar |

---

## Git

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>lz` | Normal | Open LazyGit |
| `<leader>gp` | Normal | Previous hunk |
| `<leader>gn` | Normal | Next hunk |
| `<leader>gr` | Normal | Reset hunk |
| `<leader>gb` | Normal | Blame line |

---

## Debugger (DAP)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>os` | Normal | Start/Continue |
| `<leader>oj` | Normal | Step Over |
| `<leader>ok` | Normal | Step Into |
| `<leader>ol` | Normal | Step Out |
| `<leader>ob` | Normal | Toggle Breakpoint |
| `<leader>oB` | Normal | Set Conditional Breakpoint |
| `<leader>op` | Normal | Toggle DAP UI |

---

## File Explorer

### Ranger (rnvimr)

| Key | Mode | Description |
|-----|------|-------------|
| `<M-o>` | Normal | Toggle Ranger |
| `<M-o>` | Terminal | Toggle Ranger |
| `<M-i>` | Terminal | Resize Ranger |
| `<M-l>` | Terminal | Resize preset 1,8,9,11,5 |
| `<M-y>` | Terminal | Resize preset 6 |

**Ranger Built-in:**

| Key | Description |
|-----|-------------|
| `<C-t>` | Open in new tab |
| `<C-x>` | Open in split |
| `<C-v>` | Open in vsplit |
| `gw` | Jump to nvim cwd |
| `yw` | Emit ranger cwd and jump |

---

## Editing

### AutoCompletion (nvim-cmp)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-o>` | Insert | Open completion menu |
| `<C-f>` | Insert | Close completion menu |
| `<C-j>` | Insert | Select next item |
| `<C-k>` | Insert | Select previous item |
| `<CR>` | Insert | Confirm selection |

### Surround (nvim-surround)

| Key | Mode | Description |
|-----|------|-------------|
| `ys{motion}{char}` | Normal | Add surround |
| `cs{old}{new}` | Normal | Change surround |
| `ds{char}` | Normal | Delete surround |
| `S{char}` | Visual | Surround selection |
| `yse` | Normal | Add LaTeX environment (tex only) |

### Multi-Cursor (vim-visual-multi)

| Key | Mode | Description |
|-----|------|-------------|
| `<C-n>` | Normal/Visual | Start multi-cursor |

### Commentary

| Key | Mode | Description |
|-----|------|-------------|
| `gc{motion}` | Normal | Toggle comment |
| `gcc` | Normal | Toggle comment line |

### Toggle Bool

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>s` | Normal | Toggle boolean value |

### EasyAlign

| Key | Mode | Description |
|-----|------|-------------|
| `ga{motion}` | Normal | Start EasyAlign |
| `ga` | Visual | Start EasyAlign |

### Formatter (Conform)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ff` | Normal/Visual | Format file or range |
| `<leader>fc` | Normal | Toggle format on save |

### Folding (nvim-ufo)

| Key | Mode | Description |
|-----|------|-------------|
| `za` | Normal | Toggle fold |
| `zc` | Normal | Close fold |
| `zo` | Normal | Open fold |
| `zM` | Normal | Close all folds |
| `zR` | Normal | Open all folds |

---

## Markdown

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>mp` | Normal | Toggle Markdown preview |
| `<leader>mt` | Normal | Toggle Table mode |
| `<leader>mg` | Normal | Generate TOC (GFM) |
| `<leader>mc` | Normal | Update TOC |

---

## Miscellaneous

### Translate

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ts` | Normal/Visual | Translate text |

### Yank (Neoclip)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>y` | Normal | Open yank history |

**Neoclip Telescope (Insert Mode):**

| Key | Description |
|-----|-------------|
| `<CR>` | Select |
| `<C-p>` | Paste |
| `<C-k>` | Paste behind |
| `<C-q>` | Replay macro |
| `<C-d>` | Delete entry |
| `<C-e>` | Edit entry |

### Undo Tree

| Key | Mode | Description |
|-----|------|-------------|
| `tu` | Normal | Toggle Undo tree |

### Window Management

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>fz` | Normal | Toggle zoom (NeoZoom) |

### Winbar (Dropbar)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>;` | Normal | Pick from winbar |

### Fun

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>rr` | Normal | Make it rain (Cellular Automaton) |

### Copilot

| Key | Mode | Description |
|-----|------|-------------|
| `<Tab>` | Insert | Accept suggestion (default) |

---

## Quick Reference Card

### Most Used

| Key | Description |
|-----|-------------|
| `<leader>tf` | Find files |
| `<C-f>` | Grep search |
| `<C-l>` | Go to definition |
| `<leader>aw` | Code action |
| `<leader>ff` | Format |
| `<leader>lz` | LazyGit |
| `f` | Flash jump |
| `<M-o>` | Ranger |
| `<C-t>` | NERDTree |
| `<C-q>` | Command palette |
