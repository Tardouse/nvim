return {
	{
		-- focus mode
		"junegunn/goyo.vim",
		config = function() end,
	},
	{
		-- https://github.com/preservim/nerdtree.git
		"preservim/nerdtree",
		config = function()
			-- vim.g.NERDTreeDirArrowExpandable="+"
			-- vim.g.NERDTreeDirArrowCollapsible="-"
		end,
	},
	{
		-- statusline
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"Mofiqul/dracula.nvim",
		},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					-- theme = 'dracula-nvim',
					theme = "catppuccin-nvim",
					-- theme = 'auto',
					-- component_separators = { left = '', right = '' },
					-- section_separators = { left = '', right = '' },
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {},
					lualine_x = {
						{
							"lsp_status",
							icon = "", -- f013
							symbols = {
								-- Standard unicode symbols to cycle through for LSP progress:
								spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
								-- Standard unicode symbol for when LSP is done:
								done = "✓",
								-- Delimiter inserted between LSP names:
								separator = " ",
							},
							-- List of LSP names to ignore (e.g., `null-ls`):
							ignore_lsp = {},
							-- Display the LSP name
							show_name = true,
						},
					},
					lualine_y = { "filesize", "filetype" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				-- tabline = {
				--     lualine_a = {'buffers'},
				--     lualine_b = {},
				--     lualine_c = {'filename'},
				--     lualine_x = {},
				--     lualine_y = {},
				--     lualine_z = {'tabs'}
				-- },
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
}
