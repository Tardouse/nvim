return {
	{
		"ap/vim-css-color",
		lazy = false,
		priority = 1000,
		config = function()
		end,
	},
	{
		"ryanoasis/vim-devicons",
		lazy = false,
		priority = 1000,
		config = function()
		end,
	},
	{
		"rafi/awesome-vim-colorschemes",
		lazy = false,
		priority = 1000,
		config = function()
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
		},
		config = function()
			-- vim.cmd[[colorscheme tokyonight-night]]
			vim.cmd [[colorscheme space-vim-dark]]
		end
	}
}

