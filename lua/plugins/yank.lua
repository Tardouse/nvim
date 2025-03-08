return {
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			'nvim-telescope/telescope.nvim',
			{ 'kkharji/sqlite.lua', module = 'sqlite' },
		},
		config = function()
			vim.keymap.set("n", "<leader>y", ":Telescope neoclip<CR>", { noremap = true })
			require('neoclip').setup({
				history = 1000,
				enable_persistent_history = true,
				keys = {
					telescope = {
						i = {
							select = '<cr>',
							paste = '<c-p>',
							paste_behind = '<c-k>',
							replay = '<c-q>', -- replay a macro
							delete = '<c-d>', -- delete an entry
							edit = '<c-e>', -- edit an entry
							custom = {},
						},
						n = {
							select = '<cr>',
							paste = 'p',
							paste_behind = 'P',
							replay = 'q',
							delete = 'd',
							edit = 'e',
							custom = {},
						},
					},
				},
			})
		end
	},
}
