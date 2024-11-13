return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { 'markdown' }
			vim.g.mkdp_open_to_the_world = 1
			vim.g.mkdp_open_ip = '127.0.0.1'
			vim.g.mkdp_port = 4399

			vim.cmd([[
				function! EchoUrl(url)
					:echo a:url
				endfunction

				function OpenMarkdownPreview(url)
					execute "silent ! google-chrome-stable " . a:url
				endfunction
				function! OpenMarkdownPreviewDarwin(url)
					if a:url =~ '^file://'
						let l:local_url = substitute(a:url, '^file://', '', '')
						execute 'silent !open -a Google\ Chrome -n --args ' . l:local_url
					else
						execute 'silent !open -a Google\ Chrome -n --args ' . a:url
					endif
				endfunction
			]])

			local sysname = vim.loop.os_uname().sysname
			if sysname == 'Linux' then
				if vim.env.SSH_CONNECTION then
					vim.g.mkdp_browserfunc = 'EchoUrl'
				else
					vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
				end
			elseif sysname == 'Darwin' then
				vim.g.mkdp_browserfunc = 'OpenMarkdownPreviewDarwin'
			end
		end,
		ft = { "markdown" },
		config = function()
			-- Define key mappings
			vim.api.nvim_set_keymap('n', 'tm', ':MarkdownPreviewToggle<CR>', { noremap = true })
		end
	},
	{
		"dhruvasagar/vim-table-mode",
		cmd = { "TableModeToggle", "TableModeEnable", "TableModeDisable" },
		ft = { "markdown" },
		config = function()
			vim.cmd [[
                nnoremap tt :TableModeToggle<CR>
            ]]
		end
	},
	{
		'mzlogin/vim-markdown-toc',
		ft = { "markdown" },
		cmd = { "GenTocGFM" },
		config = function()
			-- auto update toc on save
			vim.g.vmt_auto_update_on_save = 1
			-- if set to 1, don't add <!-- vim-markdown-toc -->, and can't update toc by :UpdateToc
			vim.g.vmt_dont_insert_fence = 0
			-- if set to 0, * is used to denote every level of a list,
			-- if set to 1, vmt_cycle_list_item_markers is used to denote every level of a list
			vim.g.vmt_cycle_list_item_markers = 0
			vim.cmd [[
                nnoremap <leader>mg :GenTocGFM<CR>
                nnoremap <leader>mc :UpdateToc<CR>
            ]]
		end
	}
}
