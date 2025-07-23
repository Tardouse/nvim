return {
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
            schemaStore = { enable = false, url = "" },
            validate = false,
            customTags = {
                "!fn", "!And", "!If", "!Not", "!Equals", "!Or",
                "!FindInMap sequence", "!Base64", "!Cidr", "!Ref", "!Sub",
                "!GetAtt", "!GetAZs", "!ImportValue", "!Select", "!Split",
                "!Join sequence",
            },
        },
    },
    -- -- for test config whether load
    -- on_attach = function(client, bufnr)
    --     -- Add a notification to confirm that lua_ls is attached.
    --     vim.notify("yamlls attached to buffer " .. bufnr, vim.log.levels.INFO, {
    --         title = "LSP Notification"
    --     })
    -- end,
}
