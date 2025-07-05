local M = {}

M.setup = function(lspconfig, opts)
    lspconfig.yamlls.setup({
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
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
    })
end

return M
