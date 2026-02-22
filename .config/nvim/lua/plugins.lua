vim.pack.add({
	{ src = "https://github.com/jiaoshijie/undotree" },
	{ src = "https://github.com/monkoose/neocodeium" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-mini/mini.files" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",                            version = "main" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/adriankarlen/plugin-view.nvim" },
	{ src = "https://github.com/vague-theme/vague.nvim" },
	{ src = "https://github.com/olimorris/onedarkpro.nvim" },
	{ src = "https://github.com/strash/everybody-wants-that-line.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/pteroctopus/faster.nvim" },
	{ src = "https://github.com/smithbm2316/centerpad.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-lint" },
	{ src = "https://github.com/nvim-orgmode/orgmode" },
	{ src = "https://github.com/nvim-orgmode/org-bullets.nvim" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/sontungexpt/vietnamese.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{
	    src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",

	    opt = false, -- force start plugin

	    build = function(plugin)
	      vim.system({
	        "cmake",
	        "-S.", "-Bbuild",
	        "-DCMAKE_BUILD_TYPE=Release"
	      }, { cwd = plugin.path }):wait()

	      vim.system({
	        "cmake",
	        "--build", "build",
	        "--config", "Release"
	      }, { cwd = plugin.path }):wait()
	    end,
	},
	{ src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/MysticalDevil/inlay-hints.nvim" },
	{ src = "https://github.com/jake-stewart/multicursor.nvim" },
	{ src = "https://github.com/ThePrimeagen/refactoring.nvim" },
})

require("plugin-view").setup()
