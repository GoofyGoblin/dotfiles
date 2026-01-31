require("oil").setup()
require("mason").setup()
-- lsp
vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"html",
	"cssls",
	"bashls",
	"pyright",
	"jsonls",
	"clangd",
	"tailwindcss",
})


-- autocompletion
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local bufnr = args.buf
		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end
	end,
})

vim.cmd([[set completeopt+=menuone,noselect,popup]])

local neocodeium = require("neocodeium")
neocodeium.setup()

-- theme
require("vague").setup({})
-- vim.cmd("colorscheme vague")
-- vim.cmd.("colorscheme kanagawa_lotus")
-- vim.cmd("colorscheme onelight")
vim.cmd("colorscheme onedark_dark")

-- statusbar
require("everybody-wants-that-line").setup({
	buffer = {
		enabled = true,
		prefix = "B:",
		symbol = "0",
		max_symbols = 5,
	},
	diagnostics = {
		enabled = true,
	},
	quickfix_list = {
		enabled = true,
	},
	git_status = {
		enabled = true,
	},
	filepath = {
		enabled = true,
		path = "relative",
		shorten = true,
	},
	filesize = {
		enabled = true,
		metric = "decimal",
	},
	ruller = {
		enabled = true,
	},
	filename = {
		enabled = false,
	},
	separator = "│",
})

-- big files
require('faster').setup()

-- nvim-lint
local lint = require("lint")
require("lint").linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	python = { "ruff" },
	lua = { "luacheck" },
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
})

-- org mode
require("orgmode").setup({
	org_agenda_files = "~/notes/**/*",
	org_default_notes_file = "~/notes/refile.org",
})
require("org-bullets").setup({
	concealcursor = true,
})

-- flash
require("flash").setup()

-- blink cmp
local blink = require("blink.cmp")

blink.setup({
	keymap = { preset = "enter" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	completion = {
		menu = { border = "rounded" },
		documentation = {
			auto_show = true,
			window = { border = "rounded" },
		},
		ghost_text = { enabled = true },
	},
	signature = {
		enabled = true,
		window = { border = "rounded" },
	},
	fuzzy = {
		implementation = "lua",
	},
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Apply capabilities to ALL servers
vim.lsp.config("*", {
	capabilities = capabilities,
})

-- Configure servers registered by nvim-lspconfig
vim.lsp.config("lua_ls", {})
vim.lsp.config("pyright", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("html-lsp", {})

--lua snip
require("luasnip.loaders.from_vscode").lazy_load()


--fzf-lua
require("fzf-lua").setup({
    keymap = {
        fzf = {
            ["ctrl-q"] = "select-all+accept",
        },
    },
})

-- treesitter
vim.cmd('packadd nvim-treesitter')

require('nvim-treesitter.config').setup({


  highlight = {
    enable = true, -- This replaces your manual vim.treesitter.start()
  },
  -- Ensure parsers are installed
  ensure_installed = { "javascript", "typescript", "lua", "python" },
})


require("vietnamese").setup()

-- autopairs
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
