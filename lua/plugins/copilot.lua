return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_enabled = false
			-- vim.keymap.set('i', '<>', 'copilot#Accept("\\<CR>")', {
			-- 	expr = true,
			-- 	replace_keycodes = false
			-- })
			-- vim.g.copilot_no_tab_map = true
			vim.g.copilot_filetypes = {
				TelescopePrompt = false,
			}
		end
	}
}
