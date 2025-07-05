-- ***************************************************
-- fixed bug: position_encoding param is required in vim.lsp.util.make_position_params. Defaulting to position encoding of the first client.
-- enable lua module caching for faster startup (neovim 0.9+)
pcall(require, 'vim.loader')
if vim.loader then
    vim.loader.enable()
end

local util = require('vim.lsp.util')

-- Store the original function
local original_make_position_params = util.make_position_params

-- Override make_position_params to provide default position_encoding
util.make_position_params = function(win, offset_encoding)
    -- Fallback to 'utf-16' if offset_encoding is not provided
    offset_encoding = offset_encoding or 'utf-16'
    return original_make_position_params(win, offset_encoding)
end
-- ***************************************************

require("defaults")
require("keymaps")
require("plugins")

-- setup colorscheme
