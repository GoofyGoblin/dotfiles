return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim", -- Helps manage DAP adapters
		{
			"williamboman/mason.nvim",
			opts = function(_, opts)
				-- Ensure js-debug-adapter is installed by Mason
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "js-debug-adapter")
			end,
		},
	},
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
	config = function()
		require("mason-nvim-dap").setup({
			-- list of debuggers to ensure are installed
			-- debugger_path = vim.fn.stdpath("data")
			-- 	.. "/lazy/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			-- adapters = { "pwa-node", "pwa-chrome", "pwa-extensionHost" },
			ensure_installed = { "js-debug-adapter" },
			automatic_installation = true,
			-- auto_attach_generated_launch_configs = true, -- optional
		})

		local dap, dapui = require("dap"), require("dapui")
		for _, language in ipairs({ "javascript", "typescript" }) do
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					-- This path must point to the 'dapDebugServer.js' file in your Mason folder
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}
			dap.adapters["pwa-chrome"] = dap.adapters["pwa-node"]
			require("dap").configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch Chrome to debug client",
					-- processId = require("dap.utils").pick_process,
					-- cwd = "${workspaceFolder}",
					url = "https://localhost:5173",
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}/src",
					skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
				},

				{
					type = "pwa-chrome",
					request = "attach",
					name = "Attach Chrome (Live Server)",
					port = 9222,
					url = "https://localhost:5500",
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "**/node_modules/**" },
				},
				language == "javascript"
						and {
							-- use nvim-dap-vscode-js's pwa-node debug adapter
							type = "pwa-node",
							-- launch a new process to attach the debugger to
							request = "launch",
							-- name of the debug action you have to select for this config
							name = "Launch file in new node process",
							-- launch current file
							program = "${file}",
							cwd = "${workspaceFolder}",
						}
					or nil,
			}
		end

		require("dapui").setup()
		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open({ reset = true })
		end
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
		-- end
		-- Manual adapter setup (alternative to mason-nvim-dap if needed)
		-- The mason-nvim-dap plugin usually handles this for "js-debug-adapter",
		-- but you might need a manual entry for specific scenarios (e.g., legacy "pwa-node").
		-- Example for pwa-node:
		-- if not dap.adapters["pwa-node"] then
		--   require("dap").adapters["pwa-node"] = {
		--     type = "server",
		--     host = "localhost",
		--     port = "${port}",
		--     executable = {
		--       command = "node",
		--       args = { require("lazy.core.config").get_pkg_path("js-debug-adapter") .. "/js-debug/src/dapDebugServer.js", "${port}" },
		--     },
		--   }
		-- end
	end,
}
