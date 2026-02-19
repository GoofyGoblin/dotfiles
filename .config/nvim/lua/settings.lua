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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})




local neocodeium = require("neocodeium")
neocodeium.setup()

-- theme
require("vague").setup({})
vim.cmd("colorscheme vague")
-- vim.cmd.("colorscheme kanagawa_lotus")
-- vim.cmd("colorscheme onelight")
-- require("onedarkpro").setup({
--   highlights = {
--     Comment = { italic = true },
--     ErrorMsg = { italic = true, bold = true }
--   },
--   plugins = {
--     nvim_lsp = true,
-- 	treesitter = true
--   }
-- })
-- local pywal16 = require('pywal16')
-- pywal16.setup()
-- vim.cmd("colorscheme onedark")

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

vim.lsp.config("ts_ls", {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})


--lua snip
require("luasnip.loaders.from_vscode").lazy_load()


--telescope
require('plenary')
require('telescope').setup {
	defaults = {
		preview = {
			treesitter = false,
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,          -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	}
}


require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')

-- treesitter

require('nvim-treesitter.config').setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	ensure_installed = {
		'javascript',
		'typescript',
		'tsx',
		'jsx',
		'python',
	}
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})


require("nvim-treesitter-textobjects").setup {
	select = {
		lookahead = true,
		selection_modes = {
			['@parameter.outer'] = 'v', -- charwise
			['@function.outer'] = 'V', -- linewise
		},
		include_surrounding_whitespace = false,
	},
	move = {
		set_jumps = true,
	}
}



require("vietnamese").setup()

-- autopairs
require('nvim-autopairs').setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})


-- inlay hints
require("inlay-hints").setup({
  commands = { enable = true },
  autocmd = { enable = true },
})

-- refactoring
local refactoring = require("refactoring")

refactoring.setup({
  show_success_message = true,

  prompt_func_return_type = {
    go = true,
    cpp = true,
    c = true,
    java = true,
  },

  prompt_func_param_type = {
    go = true,
    cpp = true,
    c = true,
    java = true,
  },
})

-- Optional: Telescope integration
pcall(function()
  require("telescope").load_extension("refactoring")
end)


-- mini files
require("mini.files").setup({
	options = {
		use_as_default_explorer = true
	}
});

