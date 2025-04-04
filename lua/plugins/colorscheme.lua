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
	},
	{
		'ray-x/aurora',
		init = function()
			vim.g.aurora_italic = 1
			vim.g.aurora_transparent = 1
			vim.g.aurora_bold = 0
		end,
		config = function()
			vim.cmd.colorscheme "aurora"
			-- vim.api.nvim_set_hl(0, '@number', { fg = '#e933e3' })
		end
	}
}
