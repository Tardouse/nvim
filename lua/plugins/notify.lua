return {
	"rcarriga/nvim-notify",
	config = function()
		-- 配置 nvim-notify，更多选项请参考官方文档：https://github.com/rcarriga/nvim-notify
		require("notify").setup({
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { border = "none" })
			end,
			background_colour = "#202020",
			fps = 60,
			level = 2,
			minimum_width = 50,
			render = "compact",
			stages = "fade_in_slide_out",
			timeout = 3000,
			top_down = true
		})
		-- 将 vim.notify 替换为 nvim-notify 的实现
		vim.notify = require("notify")

		-- 测试代码：在 Vim 启动时显示一条通知
		-- vim.api.nvim_create_autocmd("VimEnter", {
		-- 	callback = function()
		-- 		vim.notify("欢迎使用 nvim-notify！这是一条测试通知。", "info", { title = "测试通知" })
		-- 	end,
		-- })
	end,
}
