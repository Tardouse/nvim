-- Set options
vim.opt.number = true                    -- Show line numbers
vim.opt.relativenumber = true            --show relative line numbers
vim.opt.autoindent = true                -- Enable auto-indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4                      -- Number of spaces that a <Tab> in the file counts for (when 'expandtab' is not set).
vim.opt.shiftwidth = 4                   -- Number of spaces to use for each step of (auto)indent
vim.opt.smarttab = true                  -- Use shiftwidths at left margin, tabstops everywhere else
vim.opt.softtabstop = 4                  -- Number of spaces that a <Tab> counts for while editing
vim.opt.mouse = "a"                      -- Enable mouse support
vim.opt.modifiable = true                -- Allow buffer to be modified
vim.opt.encoding = "UTF-8"               -- Set encoding to UTF-8
vim.opt.completeopt = "menuone,noselect" -- Set completion options
---@diagnostic disable-next-line: undefined-field
vim.opt.completeopt:remove("preview")    -- Remove preview from completion options
-- vim.api.nvim_set_hl(0, "String", {ctermfg = 76}) -- Set string color to cyan
-- vim.api.nvim_set_hl(0, "Number", {ctermfg = 76}) -- Set number color to cyan

-- Enable filetype plugins and syntax highlighting
vim.cmd [[
  filetype plugin indent on
  syntax on
]]

-- Set folding settings use by ufo provider
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]]

-- Setup undodir
vim.opt.undodir = os.getenv("HOME") .. "/.local/.nvim_redo"
vim.opt.undofile = true

-- Setup clipboard
if vim.fn.has("clipboard") then
	vim.opt.clipboard = "unnamedplus"
end
