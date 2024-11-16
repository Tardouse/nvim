return {
	{
		"kevinhwang91/rnvimr",
		config = function()
			vim.g.rnvimr_enable_ex = 1
			vim.g.rnvimr_enable_picker = 1
			vim.g.rnvimr_edit_cmd = 'drop'
			vim.g.rnvimr_draw_border = 0
			vim.g.rnvimr_hide_gitignore = 1
			vim.g.rnvimr_border_attr = { fg = 14, bg = -1 }
			vim.g.rnvimr_enable_bw = 1
			vim.g.rnvimr_shadow_winblend = 70
			vim.g.rnvimr_ranger_cmd = { 'ranger', '--cmd=set draw_borders both' }
			vim.g.rnvimr_action = {
				['<C-t>'] = 'NvimEdit tabedit',
				['<C-x>'] = 'NvimEdit split',
				['<C-v>'] = 'NvimEdit vsplit',
				['gw'] = 'JumpNvimCwd',
				['yw'] = 'EmitRangerCwd'
			}
			vim.g.rnvimr_ranger_views = {
				{ minwidth = 90, ratio = {} },
				{ minwidth = 50, maxwidth = 89, ratio = { 1, 1 } },
				{ maxwidth = 49, ratio = { 1 } }
			}
			vim.g.rnvimr_layout = {
				relative = 'editor',
				width = vim.fn.float2nr(vim.fn.round(0.7 * vim.o.columns)),
				height = vim.fn.float2nr(vim.fn.round(0.7 * vim.o.lines)),
				col = vim.fn.float2nr(vim.fn.round(0.15 * vim.o.columns)),
				row = vim.fn.float2nr(vim.fn.round(0.15 * vim.o.lines)),
				style = 'minimal'
			}
			vim.g.rnvimr_presets = {
				{ width = 0.600, height = 0.600 },
				{ width = 0.800, height = 0.800 },
				{ width = 0.950, height = 0.950 },
				{ width = 0.500, height = 0.500, col = 0,   row = 0 },
				{ width = 0.500, height = 0.500, col = 0,   row = 0.5 },
				{ width = 0.500, height = 0.500, col = 0.5, row = 0 },
				{ width = 0.500, height = 0.500, col = 0.5, row = 0.5 },
				{ width = 0.500, height = 1.000, col = 0,   row = 0 },
				{ width = 0.500, height = 1.000, col = 0.5, row = 0 },
				{ width = 1.000, height = 0.500, col = 0,   row = 0 },
				{ width = 1.000, height = 0.500, col = 0,   row = 0.5 }
			}
			vim.api.nvim_set_keymap('n', '<M-o>', ':RnvimrToggle<CR>', { silent = true, noremap = true })
			vim.api.nvim_set_keymap('t', '<M-o>', '<C-\\><C-n>:RnvimrToggle<CR>', { silent = true, noremap = true })
			vim.api.nvim_set_keymap('t', '<M-i>', '<C-\\><C-n>:RnvimrResize<CR>', { silent = true, noremap = true })
			vim.api.nvim_set_keymap('t', '<M-l>', '<C-\\><C-n>:RnvimrResize 1,8,9,11,5<CR>',
				{ silent = true, noremap = true })
			vim.api.nvim_set_keymap('t', '<M-y>', '<C-\\><C-n>:RnvimrResize 6<CR>', { silent = true, noremap = true })
			vim.cmd('highlight link RnvimrNormal CursorLine')
		end
	}
}
-- return {
-- 	{
-- 		"kevinhwang91/rnvimr",
-- 		config = function()
-- 			vim.g.rnvimr_enable_ex = 1
-- 			vim.g.rnvimr_enable_picker = 1

-- 			-- Use very basic layout options for testing
-- 			vim.g.rnvimr_layout = {
-- 				relative = 'editor',
-- 				width = vim.fn.float2nr(vim.fn.round(0.5 * vim.o.columns)),
-- 				height = vim.fn.float2nr(vim.fn.round(0.5 * vim.o.lines)),
-- 				col = vim.fn.float2nr(vim.fn.round(0.25 * vim.o.columns)),
-- 				row = vim.fn.float2nr(vim.fn.round(0.25 * vim.o.lines)),
-- 				style = 'minimal'
-- 			}
-- 		end
-- 	}
-- }
-- return {
-- 	{
-- 		"kevinhwang91/rnvimr",
-- 		lazy = false,
-- 		config = function()
-- 			-- Set options
-- 			vim.g.rnvimr_enable_ex = 1
-- 			vim.g.rnvimr_enable_picker = 1
-- 			vim.g.rnvimr_edit_cmd = 'drop'
-- 			vim.g.rnvimr_draw_border = 0
-- 			vim.g.rnvimr_hide_gitignore = 1
-- 			vim.g.rnvimr_border_attr = { fg = 14, bg = -1 }
-- 			vim.g.rnvimr_enable_bw = 1
-- 			vim.g.rnvimr_shadow_winblend = 70
-- 			vim.g.rnvimr_ranger_cmd = { 'ranger', '--cmd=set draw_borders both' }
-- 			vim.g.rnvimr_action = {
-- 				['<C-t>'] = 'NvimEdit tabedit',
-- 				['<C-x>'] = 'NvimEdit split',
-- 				['<C-v>'] = 'NvimEdit vsplit',
-- 				['gw'] = 'JumpNvimCwd',
-- 				['yw'] = 'EmitRangerCwd'
-- 			}
-- 			vim.g.rnvimr_ranger_views = {
-- 				{ minwidth = 90, ratio = {} },
-- 				{ minwidth = 50, maxwidth = 89, ratio = { 1, 1 } },
-- 				{ maxwidth = 49, ratio = { 1 } }
-- 			}
-- 			vim.g.rnvimr_layout = {
-- 				relative = 'editor',
-- 				width = vim.fn.float2nr(vim.fn.round(0.7 * vim.o.columns)),
-- 				height = vim.fn.float2nr(vim.fn.round(0.7 * vim.o.lines)),
-- 				col = vim.fn.float2nr(vim.fn.round(0.15 * vim.o.columns)),
-- 				row = vim.fn.float2nr(vim.fn.round(0.15 * vim.o.lines)),
-- 				style = 'minimal'
-- 			}
-- 			vim.g.rnvimr_presets = {
-- 				{ width = 0.600, height = 0.600 },
-- 				{},
-- 				{ width = 0.800, height = 0.800 },
-- 				{ width = 0.950, height = 0.950 },
-- 				{ width = 0.500, height = 0.500, col = 0,   row = 0 },
-- 				{ width = 0.500, height = 0.500, col = 0,   row = 0.5 },
-- 				{ width = 0.500, height = 0.500, col = 0.5, row = 0 },
-- 				{ width = 0.500, height = 0.500, col = 0.5, row = 0.5 },
-- 				{ width = 0.500, height = 1.000, col = 0,   row = 0 },
-- 				{ width = 0.500, height = 1.000, col = 0.5, row = 0 },
-- 				{ width = 1.000, height = 0.500, col = 0,   row = 0 },
-- 				{ width = 1.000, height = 0.500, col = 0,   row = 0.5 }
-- 			}

-- 			-- Key mappings
-- 			vim.api.nvim_set_keymap('n', '<M-o>', ':RnvimrToggle<CR>', { silent = true, noremap = true })
-- 			vim.api.nvim_set_keymap('t', '<M-o>', '<C-\\><C-n>:RnvimrToggle<CR>', { silent = true, noremap = true })
-- 			vim.api.nvim_set_keymap('t', '<M-i>', '<C-\\><C-n>:RnvimrResize<CR>', { silent = true, noremap = true })
-- 			vim.api.nvim_set_keymap('t', '<M-l>', '<C-\\><C-n>:RnvimrResize 1,8,9,11,5<CR>',
-- 				{ silent = true, noremap = true })
-- 			vim.api.nvim_set_keymap('t', '<M-y>', '<C-\\><C-n>:RnvimrResize 6<CR>', { silent = true, noremap = true })

-- 			-- Link highlight groups
-- 			vim.cmd('highlight link RnvimrNormal CursorLine')
-- 		end
-- 	}
-- }
