return {
	"nvim-mini/mini.nvim",
	version = "*",

	config = function()
		require("mini.basics").setup()
		require("mini.files").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.statusline").setup()
		require("mini.bufremove").setup()
		require("mini.pick").setup({
			mappings = {
				-- Custom mapping to send all current matches to quickfix
				send_to_qf = {
					char = "<C-q>",
					func = function()
						local picker = MiniPick.get_picker_matches()
						if picker then
							MiniPick.default_choose_marked(MiniPick.get_picker_matches().all)
						end
					end,
				},
			},
		})
		-- require("mini.indentscope").setup()
	end,
}
