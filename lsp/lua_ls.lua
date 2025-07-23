return {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {
                    'vim',
                    'require',
                },
            },
            workspace = {
                checkThirdParty = false,
            },
            completion = {
                callSnippet = 'Replace',
            },
        },
    },
    -- -- for test whether work
    -- on_attach = function(client, bufnr)
    --     -- Add a notification to confirm that lua_ls is attached.
    --     vim.notify("lua_ls attached to buffer " .. bufnr, vim.log.levels.INFO, {
    --         title = "LSP Notification"
    --     })
    -- end,
}
