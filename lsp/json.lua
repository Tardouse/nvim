return {
    setup = function(lspconfig, opts)
        lspconfig.jsonls.setup(vim.tbl_deep_extend('force', opts or {}, {}))
    end,
}
