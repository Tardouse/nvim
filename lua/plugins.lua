local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    require("plugins.telescope").config,
    require("plugins.fzf"),
    require("plugins.colorscheme"),
    require("plugins.notify"),
    require("plugins.transparent"),
    require("plugins.vimlayouts"),
    require("plugins.tabline"),
    require("plugins.undo"),
    require("plugins.csv"),
    require("plugins.surround"),
    require("plugins.git"),
    require("plugins.treesitter"), -- indent's dependency
    require("plugins.indent"),
    require("plugins.editor"),
    require("plugins.wilder"),
    require("plugins.snippets"),
    require("plugins.formatter"),
    require("plugins.autocomplete").config,
    require("plugins.debugger"),
    require("plugins.lspconfig").config,
    require("plugins.commentary"),
    require("plugins.toggle_bool"),
    require("plugins.markdown"),
    require("plugins.yank"),
    require("plugins.FileProcess"),
    require("plugins.flash"),
    require("plugins.tex"),
    require("plugins.winbar"),
    require("plugins.window-management"),
    require("plugins.multi-cursor"),
    -- require("plugins.yazi"),
    require("plugins.ranger"),
    require("plugins.copilot"),
    -- require("plugins.translate"),
    require("plugins.fun"),
    require("plugins.gemini"),
})
