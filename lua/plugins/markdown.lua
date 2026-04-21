return {
	{
		"Tardouse/md-tool.nvim",
		ft = { "markdown" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		build = function(plugin)
			dofile(plugin.dir .. "/lua/md-tool/install.lua").build(plugin.dir)
		end,
		opts = {
			render = {
				enabled = true,
				hide_in_insert = true,
				modes = { "n", "v", "V", "\22", "c" },

				-- [CN] 渲染刷新防抖时间，单位毫秒；`0` 表示不额外等待。
				debounce = 80,

				-- [CN] 超过该文件大小后跳过渲染，单位 MB，用于避免大文件卡顿。
				-- [CN] 可选值: 任意正数。
				max_file_size = 5.0,

				-- [CN] 只渲染当前窗口可见区域，减少整 buffer 重绘。
				-- [CN] 可选值: `true` / `false`。
				visible_only = true,

				-- [CN] 是否在光标所在行隐藏渲染效果并回退为原始 Markdown。
				-- [CN] 可选值: `true` / `false`。
				hide_on_cursorline = true,

				-- [CN] 仅在普通模式下生效；让光标跳过被 conceal 的 Markdown 分隔符。
				-- [CN] 可选值: `true` / `false`。
				skip_concealed = true,

				heading = {
					-- [CN] 是否增强标题显示。
					-- [CN] 可选值: `true` / `false`。
					enabled = true,

					-- [CN] 标题层级图标列表；长度不足 6 时会按层级循环使用。
					-- [CN] 可选值: 任意非空字符串数组。
					icons = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " },

					-- [CN] 是否给整行标题增加额外高亮，包括 setext 标题的下划线行。
					-- [CN] 可选值: `true` / `false`。
					highlight_line = true,
				},

				bullet = {
					-- [CN] 是否替换无序列表符号的显示。
					-- [CN] 可选值: `true` / `false`。
					enabled = true,

					-- [CN] 无序列表图标列表；嵌套层级增加时会循环使用。
					-- [CN] 可选值: 任意非空字符串数组。
					icons = { "● ", "○ ", "◆ ", "◇ " },
				},

				checkbox = {
					-- [CN] 是否替换任务列表 checkbox 的显示。
					-- [CN] 可选值: `true` / `false`。
					enabled = true,

					-- [CN] 未勾选任务项显示的图标。
					-- [CN] 可选值: 任意字符串。
					unchecked = "☐ ",

					-- [CN] 已勾选任务项显示的图标。
					-- [CN] 可选值: 任意字符串。
					checked = "☑ ",

					-- [CN] 部分完成任务项显示的图标，对应 Markdown 里的 `[-]`。
					-- [CN] 可选值: 任意字符串。
					partial = "◐ ",
				},

				quote = {
					-- [CN] 是否增强 blockquote 显示。
					-- [CN] 可选值: `true` / `false`。
					enabled = true,

					-- [CN] 引用前缀字符；嵌套引用会重复该字符。
					-- [CN] 可选值: 任意字符串。
					icon = "▎",
				},

				callout = {
					-- [CN] 是否增强 `[!NOTE]` / `[!WARNING]` 这类 callout。
					-- [CN] 常见可识别类型: NOTE, INFO, TIP, HINT, SUCCESS, WARNING, CAUTION, DANGER, ERROR, QUESTION, EXAMPLE, QUOTE 等。
					-- [CN] 可选值: `true` / `false`。
					enabled = true,
				},

				code = {
					-- [CN] 是否增强 fenced code block 的显示。
					-- [CN] 可选值: `true` / `false`。
					enabled = true,

					-- [CN] 是否为代码块添加上下边框。
					-- [CN] 可选值: `true` / `false`。
					border = true,

					-- [CN] 是否在代码块起始行显示语言标签；需要围栏后带 info string。
					-- [CN] 可选值: `true` / `false`。
					language = true,

					-- [CN] 代码块装饰宽度的下限，避免窄窗口下边框太短。
					-- [CN] 可选值: 任意正整数。
					min_width = 24,
				},

				hr = {
					-- [CN] 是否增强分割线显示。
					-- [CN] 可选值: `true` / `false`。
					enabled = true,

					-- [CN] 用于铺满窗口宽度的分割线字符。
					-- [CN] 可选值: 任意字符串。
					char = "─",
				},

				table = {
					-- [CN] 是否增强 pipe table 的显示。
					-- [CN] 可选值: `true` / `false`。
					enabled = true,

					-- [CN] 是否用更明显的竖线字符替换表格边框。
					-- [CN] 可选值: `true` / `false`。
					border = true,

					-- [CN] 是否高亮分隔行中的对齐冒号，不会改动原文。
					-- [CN] 可选值: `true` / `false`。
					align = true,
				},

				link = {
					-- [CN] 链接渲染配置入口；当前版本配置已保留，
					-- [CN] 可选值: `true` / `false`。
					enabled = true,

					-- [CN] 普通链接前缀图标；当前版本为预留字段，
					-- [CN] 可选值: 任意字符串。
					icon = "↗ ",

					-- [CN] Wikilink 前缀图标；当前版本为预留字段，
					-- [CN] 可选值: 任意字符串。
					wikilink_icon = "§ ",

					-- [CN] 图片链接前缀图标；当前版本为预留字段，
					-- [CN] 可选值: 任意字符串。
					image_icon = "◫ ",
				},
			},

			preview = {
				-- [CN] 仅控制“预览模块是否允许启用”；不会在打开 Markdown 时自动打开浏览器预览。
				-- [CN] 可选值: `true` / `false`。
				enabled = true,

				-- [CN] 本地预览服务绑定地址。
				-- [CN] 可选值: 任意字符串，例如 `"127.0.0.1"`、`"0.0.0.0"`、`"localhost"`。
				host = "127.0.0.1",

				-- [CN] 本地预览服务端口。
				-- [CN] 可选值: 任意正整数。
				port = 4399,

				-- [CN] 预览服务二进制路径。
				-- [CN] 可选值: `"auto"` 或可执行文件路径。
				-- [CN] `"auto"` 会依次尝试插件目录下的 `bin/`、`target/release/`、`target/debug/`，最后再查找 `$PATH`。
				binary = "auto",

				-- [CN] Markdown 内容推送到本地服务前的防抖时间，单位毫秒。
				-- [CN] 可选值: 任意非负整数。
				debounce = 150,

				-- [CN] 启动预览服务后的就绪等待时间，单位毫秒。
				-- [CN] 可选值: 任意正整数。
				startup_timeout = 5000,

				-- [CN] 预览服务日志级别。
				-- [CN] 可选值: `"trace"`、`"debug"`、`"info"`、`"warn"`、`"error"`。
				log_level = "info",

				-- [CN] 是否在启用预览时自动打开浏览器。
				-- [CN] 可选值: `true`、`false`、`"auto"`。
				-- [CN] `"auto"` 会在本地环境自动打开，在 SSH/远程环境退化为只回显 URL。
				auto_open = "auto",

				-- [CN] 浏览器/打开器命令。
				-- [CN] 可选值: `"auto"`、`"echo"`、或自定义命令字符串。
				-- [CN] 自定义命令可包含 `%s` 占位符；若不包含，插件会把 URL 追加到命令末尾。
				browser = "google-chrome-stable",

				-- [CN] 是否在消息区回显预览 URL；即使禁用自动打开，也建议保留为 `true`。
				-- [CN] 可选值: `true` / `false`。
				echo_url = true,
			},

			table = {
				-- [CN] 是否默认启用 table mode。
				-- [CN] 开启后会为 Markdown buffer 注册表格编辑辅助，并在编辑当前表格时自动格式化。
				-- [CN] 可选值: `true` / `false`。
				enabled = false,

				-- [CN] 预留字段，当前版本仅做校验和保留，尚未被表格模块实际消费。
				-- [CN] 可选值: `true` / `false`。
				auto_align = false,

				-- [CN] 保存前是否格式化当前 buffer 里的所有 Markdown 表格。
				-- [CN] 可选值: `true` / `false`。
				format_on_save = false,
			},

			toc = {
				-- [CN] 保存文件时是否自动更新现有 TOC。
				-- [CN] 可选值: `true` / `false`。
				auto_update_on_save = true,

				-- [CN] TOC 列表项使用的无序列表符号。
				-- [CN] 可选值: `"-"`、`"*"`、`"+"`。
				list_marker = "-",

				-- [CN] 目录收集的最大标题层级；Markdown 实际只支持 1 到 6 级，设置大于 6 与 6 等效。
				-- [CN] 可选值: 任意正整数，通常建议 `1` 到 `6`。
				max_depth = 6,

				-- [CN] TOC 起始标记行；需要和 `fence_end` 成对使用。
				-- [CN] 可选值: 任意字符串。
				fence_start = "<!-- markdown-toc-start -->",

				-- [CN] TOC 结束标记行；需要和 `fence_start` 成对使用。
				-- [CN] 可选值: 任意字符串。
				fence_end = "<!-- markdown-toc-end -->",

				-- [CN] 控制 `MDTtocGen` 的行为。
				-- [CN] 可选值: `true` = 优先按更新模式处理；`false` = 总是在当前光标位置插入一个新的 TOC 块。
				GenAsUpdate = true,
			},

			list = {
				-- [CN] 是否默认启用 Markdown 列表续写模块。
				-- [CN] 可选值: `true` / `false`。
				enabled = true,

				-- [CN] 是否续写有序列表，例如 `1.` / `2)`。
				-- [CN] 可选值: `true` / `false`。
				ordered = true,

				-- [CN] 是否续写无序列表，例如 `-` / `*` / `+`。
				-- [CN] 可选值: `true` / `false`。
				unordered = true,

				-- [CN] 是否续写任务列表，例如 `- [ ]` / `- [x]`。
				-- [CN] 可选值: `true` / `false`。
				checklist = true,

				-- [CN] 当前列表项为空时，按回车是否退出列表而不是继续生成下一项。
				-- [CN] 可选值: `true` / `false`。
				exit_on_empty = true,

				-- [CN] 续写有序列表时是否递增编号。
				-- [CN] 可选值: `true` = `1.` 后继续成 `2.`；`false` = 继续复用原编号。
				renumber_on_continue = true,

				-- [CN] 是否在 blockquote 内也尝试续写列表。
				-- [CN] 可选值: `true` / `false`。
				continue_in_quote = false,

				-- [CN] 续写已勾选任务项时，是否重置为未勾选。
				-- [CN] 可选值: `true` = `[x]` 续写为 `[ ]`；`false` = 保留原状态。
				checked_to_unchecked = true,
			},
		},
		keys = {
			{ "<leader>mp", "<cmd>MDTpriviewToggle<cr>", desc = "Markdown Preview Toggle" },
			{ "<leader>mt", "<cmd>MDTtableToggle<cr>", desc = "Markdown Table Toggle" },
			{ "<leader>mg", "<cmd>MDTtocGen<cr>", desc = "Markdown TOC Generate" },
			{ "<leader>mc", "<cmd>MDTtocUpdate<cr>", desc = "Markdown TOC Update" },
			{ "<leader>ml", "<cmd>MDTlistToggle<cr>", desc = "Markdown List Toggle" },
			{ "<leader>mr", "<cmd>MDTrenderToggle<cr>", desc = "Markdown Render Toggle" },
		},
	},
}
