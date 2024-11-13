return {
	{
		"kdheepak/lazygit.nvim",
		keys = { "<leader>lz" },
		config = function()
			vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
			vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
			vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } -- customize lazygit popup window border characters
			vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
			vim.g.lazygit_use_neovim_remote = true -- fallback to 0 if neovim-remote is not installed

			vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
			vim.g.lazygit_config_file_path = '' -- custom config file path

			vim.keymap.set("n", "<leader>lz", ":LazyGit<CR>", { noremap = true, silent = true })
		end
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup({
				signs = {
					add          = { text = '▎' },
					change       = { text = '░' },
					delete       = { text = '_' },
					topdelete    = { text = '▔' },
					changedelete = { text = '▒' },
					untracked    = { text = '┆' },
				},
			})
			vim.keymap.set("n", "<leader>gp", ":Gitsigns prev_hunk<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true })
		end
	},
}

