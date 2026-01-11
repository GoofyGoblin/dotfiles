return {
	"olimorris/codecompanion.nvim",
	event = "VeryLazy",
	config = function()
		require("codecompanion").setup({
			adapters = {
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						env = {
							api_key = os.getenv("GEMINI_API_KEY"),
							model = "gemini-2.5-flash",
						},
					})
				end,
			},
			strategies = {
				chat = { adapter = "gemini" },
				inline = { adapter = "gemini" },
				agent = { adapter = "gemini" },
			},
			opts = {
				log_level = "INFO",
			},
		})
	end,
}
