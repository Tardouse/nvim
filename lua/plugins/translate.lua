return {
	{
		"voldikss/vim-translator",
		init = function()
			-- 设置翻译源语言和目标语言（可以根据需要调整）
			vim.g.translator_default_from = "auto"
			vim.g.translator_default_to = "zh"

			-- 设置快捷键 <leader>sw 用于翻译
			vim.api.nvim_set_keymap('n', '<leader>sw', ':TranslateW<CR>', { noremap = true, silent = true })
			vim.api.nvim_set_keymap('v', '<leader>sw', ':TranslateW<CR>', { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<leader>sr', ':TranslateR<CR>', { noremap = true, silent = true })
			vim.api.nvim_set_keymap('v', '<leader>sr', ':TranslateR<CR>', { noremap = true, silent = true })
		end
	}
}
