return {
	'gelguy/wilder.nvim',
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local wilder = require('wilder')
		wilder.setup {
			modes = { ':', '/', '?' },
			next_key = '<c-j>',
			previous_key = '<c-k>',
		}
		wilder.set_option('renderer', wilder.popupmenu_renderer(
			wilder.popupmenu_border_theme({
				border = 'rounded',
				empty_message = wilder.popupmenu_empty_message_with_spinner(),
				highlighter = wilder.basic_highlighter(),
				left = {
					' ',
					wilder.popupmenu_devicons(),
					wilder.popupmenu_buffer_flags({
						flags = ' a + ',
						icons = { ['+'] = '', a = '', h = '' },
					}),
				},
				right = {
					' ',
					wilder.popupmenu_scrollbar(),
				},
			})
		-- wilder.popupmenu_border_theme({
		-- 	highlighter = wilder.highlighter_with_gradient({
		-- 		wilder.basic_highlighter(), -- or wilder.lua_fzy_highlighter(),
		-- 	  }),
		-- 	highlights = {
		-- 	  border = 'Normal', -- highlight to use for the border
		-- 	},
		-- 	left = { ' ', wilder.popupmenu_devicons() },
		-- 	right = { ' ', wilder.popupmenu_scrollbar() },
		-- 	-- min_width = '100%', -- minimum height of the popupmenu, can also be a number
		-- 	-- min_height = '50%', -- to set a fixed height, set max_height to the same value
		-- 	-- 'single', 'double', 'rounded' or 'solid'
		-- 	-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
		-- 	border = 'rounded',
		-- 	reverse = 0,         -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
		--   })
		))
		wilder.set_option('pipeline', {
			wilder.branch(
				wilder.cmdline_pipeline({
					-- sets the language to use, 'vim' and 'python' are supported
					language = 'vim',
					-- 0 turns off fuzzy matching
					-- 1 turns on fuzzy matching
					-- 2 partial fuzzy matching (match does not have to begin with the same first letter)
					fuzzy = 1,
				}),
				wilder.python_search_pipeline({
					-- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
					pattern = wilder.python_fuzzy_pattern(),
					-- omit to get results in the order they appear in the buffer
					sorter = wilder.python_difflib_sorter(),
					-- can be set to 're2' for performance, requires pyre2 to be installed
					-- see :h wilder#python_search() for more details
					engine = 're',
				})
			),
		})
	end
}
