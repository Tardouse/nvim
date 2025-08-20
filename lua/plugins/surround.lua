return {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			surrounds = {
				["e"] = {
					add = function()
						local ft = vim.bo.filetype
						if ft ~= "tex" and ft ~= "plaintex" and ft ~= "latex" then
							return nil
						end
						local env = vim.fn.input("Environment name: ")
						if not env or env == "" then
							return nil
						end
						local opt = vim.fn.input("Options (empty if none): ")
						local open = "\\begin{" .. env .. "}" .. (opt ~= "" and "[" .. opt .. "]" or "")
						local close = "\\end{" .. env .. "}"
						-- 控制换行：yS 多行时不会出现空白行
						return { { open .. "\n" }, { "\n" .. close } }
					end,

					-- 找到一对 begin...end（尽量温和，适配多行）
					find = "\\\\begin%b{}[^\n]*.-\n?.-\\\\end%b{}",

					-- 关键修正：delete 需要 4 个捕获组（左、空、右、空）
					-- 模式含义： ^(左)()  …  (右)()$
					-- 这里允许 begin 行末有换行，end 行前有换行，以适配多行环境
					delete = "^(\\begin%b{}[^\n]*\n?)().-(\n?\\end%b{})()$",

					-- 可选：把环境“重命名”（cs e），只改 begin/end 的名字，不动内容/可选参数
					change = {
						-- 选中 begin/end 的环境名（两侧各一个捕获 + 空组）
						target = "^\\begin{()([^}]+)()}[^\n]*\n?.-\\end{()([^}]+)()}$",
						replacement = function()
							local new = vim.fn.input("New environment: ")
							if not new or new == "" then
								return nil
							end
							-- 只替换名字本身
							return { { new }, { new } }
						end,
					},
				},
			},
		})
	end,
}

-- return {
-- 	"kylechui/nvim-surround",
-- 	version = "*",
-- 	event = "VeryLazy",
-- 	config = function()
-- 		require("nvim-surround").setup({})
-- 	end
-- }
