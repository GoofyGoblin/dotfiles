-- return {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine",
-- 	config = function()
-- 		vim.cmd("colorscheme rose-pine")
-- 	end,
-- }
return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- so it loads during startup
		priority = 1000, -- ensure it loads before other plugins
		config = function()
			require("kanagawa").setup({
				-- your overrides here, e.g.:
				transparent = false,
				theme = "kanagawa-dragon",
				-- etc.
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
}
