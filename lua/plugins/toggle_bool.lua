return {
    "gerazov/vim-toggle-bool",
    lazy = false,
    priority = 1000,
    dependencies = { "AndrewRadev/switch.vim"},
    config=function ()
        vim.cmd [[
            nnoremap <silent><leader>s :ToggleBool<CR>
        ]]
    end
}