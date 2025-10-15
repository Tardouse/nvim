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

----------------------- fcitx4 ---------------------
-- 记录上次输入法状态（1=英文，2=中文）
local fcitx_state = tonumber(vim.fn.system("fcitx-remote"))

-- 离开插入模式时：记录当前状态并关闭输入法
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    fcitx_state = tonumber(vim.fn.system("fcitx-remote"))
    if fcitx_state == 2 then
      vim.fn.system("fcitx-remote -c") -- 关闭输入法
    end
  end,
})

-- 进入插入模式时：如果上次是中文，就恢复输入法
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    if fcitx_state == 2 then
      vim.fn.system("fcitx-remote -o") -- 恢复输入法
    end
  end,
})
----------------------------------------------------


require("defaults")
require("keymaps")
require("plugins")

-- setup colorscheme

