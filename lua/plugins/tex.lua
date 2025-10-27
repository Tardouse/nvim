return {
    "lervag/vimtex",
    init = function()
        vim.g.vimtex_view_method = "zathura"
        -- vim.g.vimtex_view_general_viewer = 'okular'
        -- vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
        vim.g.vimtex_mappings_enabled = 0
        vim.g.vimtex_syntax_enabled = 0
        vim.g.vimtex_quickfix_ignore_filters = {
            'Font shape',
            "badness 10000",
            "Package hyperref Warning",
        }
    end
}
