return function(opts)
    return vim.tbl_deep_extend('force', {
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
    }, opts or {})
end
