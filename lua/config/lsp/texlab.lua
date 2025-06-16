return {
    setup = function(lspconfig, lsp)
        lspconfig.texlab.setup {
            settings = {
                texlab = {
                    build = {
                        executable = "latexmk",
                        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                        onSave = true,
                        forwardSearchAfter = true,
                    },
                    forwardSearch = {
                        executable = "zathura",
                        args = { "--synctex-forward", "%l:1:%f", "%p" },
                    },
                    chktex = {
                        onOpenAndSave = true,
                        onEdit = false,
                    },
                    diagnosticsDelay = 200,
                    latexindent = {
                        modifyLineBreaks = true,
                    },
                    formatterLineLength = 80,
                },
            },
        }
    end
}
