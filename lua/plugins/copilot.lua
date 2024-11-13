return {
	{
		"github/copilot.vim",
		config = function()
			vim.cmd('imap <silent><script><expr> <Tab> copilot#Accept("")')
			vim.cmd([[
			let g:copilot_filetypes = {
	       \ 'TelescopePrompt': v:false,
	     \ }
			]])
		end
	}
}
