return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_open_to_the_world = 1
            vim.g.mkdp_open_ip = '127.0.0.1' -- 可能需要根据实际情况调整
            vim.g.mkdp_port = 4399
            vim.api.nvim_exec([[
            function! OpenMarkdownPreview(url)
            " 判断文件是否为本地文件
            if a:url =~ '^file://'
                let l:local_url = substitute(a:url, '^file://', '', '')
                execute 'silent !open -a Google\ Chrome -n --args ' . l:local_url
            else
                execute 'silent !open -a Google\ Chrome -n --args ' . a:url
            endif
            endfunction
            let g:mkdp_browserfunc = 'OpenMarkdownPreview'
        ]], false)
        end,
        ft = { "markdown" },
        config = function()
            vim.cmd [[
                nnoremap tm :MarkdownPreviewToggle<CR>
            ]]
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
