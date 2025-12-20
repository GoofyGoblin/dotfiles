return {
	"nvim-mini/mini.nvim",
	version = "*",

	config = function()
		require("mini.basics").setup()
		require("mini.files").setup()
		require("mini.pick").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.ai").setup()
		require("mini.comment").setup()
		require("mini.statusline").setup()
		require("mini.bufremove").setup()
		-- require("mini.indentscope").setup()
	end,
}
