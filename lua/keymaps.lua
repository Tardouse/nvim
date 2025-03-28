vim.g.mapleader = " "

local nmappings = {
	-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
	{ from = "<Esc>",      to = "<cmd>nohlsearch<CR>" }, -- clear search

	-- diffget and diffput
	{ from = "<leader>dg", to = ":diffget<CR>" },
	{ from = "<leader>dp", to = ":diffput<CR>" },
	-- print some info
	{ from = "\\w",        to = ":lua print(vim.fn.expand('%:p'))<CR>" }, -- print full path of current file

	-- some layouts/function open
	{ from = "<C-t>",      to = ":NERDTreeToggle<CR>" },

	-- Regular Configration
	{ from = "<C-j>",      to = ":set paste<CR>o<Esc>:set nopaste<CR>" },

	-- buffers management
	{ from = "tp",         to = ":bprevious<CR>", },
	{ from = "tn",         to = ":bnext<CR>", },
	{ from = "td",         to = ":bdelete<CR>", },

	-- Tab management
	-- { from = "tu",            to = ":tabe<CR>", },
	-- { from = "tU",            to = ":tab split<CR>", },
	-- { from = "tp",            to = ":-tabnext<CR>", },
	-- { from = "tn",            to = ":+tabnext<CR>", },
	-- { from = "tmp",           to = ":-tabmove<CR>", },
	-- { from = "tmn",           to = ":+tabmove<CR>", },

	-- -- Other 为了作为参考修改
	-- { from = "<leader>sw",    to = ":set wrap<CR>" },
	-- { from = "<leader>sc",    to = ":set spell!<CR>" },
	-- { from = "<leader><CR>",  to = ":nohlsearch<CR>" },
	-- { from = "<f10>",         to = ":TSHighlightCapturesUnderCursor<CR>" },
	-- { from = "<leader>o",     to = "za" },
	-- { from = "<leader>pr",    to = ":profile start profile.log<CR>:profile func *<CR>:profile file *<CR>" },
	-- { from = "<leader>rc",    to = ":e ~/.config/nvim/init.lua<CR>" },
	-- { from = "<leader>rv",    to = ":e .vim.lua<CR>" },
	-- { from = ",v",            to = "v%" },
	-- { from = "<leader><esc>", to = "<nop>" },

	-- rnvimr
	-- { from = "M-o",             to = ":RnvimrToggle<CR>" },
}

for _, mapping in ipairs(nmappings) do
	vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end
