return {
	"mfussenegger/nvim-dap",
	lazy = true,
	-- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
	-- modified.

	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},

		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},

		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},

		{
			"<leader>dT",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/nvim-dap-vscode-js/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})

			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						protocol = "inspector",
						console = "integratedTerminal",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach to process",
						processId = require("dap.ext.vscode").processId,
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						protocol = "inspector",
					},
				}
			end
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		---@type MasonNvimDapSettings
		opts = {
			-- This line is essential to making automatic installation work
			-- :exploding-brain
			handlers = {},
			automatic_installation = {
				-- These will be configured by separate plugins.
				exclude = {
					"delve",
					"python",
				},
			},
			-- DAP servers: Mason will be invoked to install these if necessary.
			ensure_installed = {
				"bash",
				"codelldb",
				"php",
				"python",
			},
		},
		dependencies = {
			"mfussenegger/nvim-dap",
			"williamboman/mason.nvim",
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		config = true,
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle({})
				end,
				desc = "Dap UI",
			},
		},
		dependencies = {
			"jay-babu/mason-nvim-dap.nvim",
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = true,
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	-- local dap = require("dap")
	-- -- dap.adapters.php = {
	-- --     type = "executable",
	-- --     command = "node",
	-- --     args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/php-debug-adapter/dist/debugAdapter.js" },
	-- dap.adapters["pwa-node"] = {
	--     type = "server",
	--     host = "127.0.0.1",
	--     port = 8080,
	--     executable = {
	--             command = "js-debug-adapter",
	--             args = { "--debugServerPort", "8080" },
	-- },
}
