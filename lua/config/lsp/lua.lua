return function(opts)
    require('neodev').setup({ lspconfig = true, override = function() end })
    return vim.tbl_deep_extend('force', {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim', 'require' },
                },
                workspace = {
                    checkThirdParty = false,
                },
                completion = {
                    callSnippet = 'Replace',
                },
            },
        },
    }, opts or {})
end
