return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- Delay before the popup appears (in ms)
			-- 300ms is the "sweet spot" for speed without being annoying
			delay = 300,
			icons = {
				breadcrumb = "»",
				separator = "➜",
				group = "+",
			},
			spec = {
				-- Here we group your keys so the menu looks organized
				{ "<leader>f", group = "Find (Telescope)" },
				{ "<leader>b", desc = "Breakpoint" },
				{ "<leader>a", desc = "Harpoon Add" },
				-- Debugging Groups
				{ "<M-1>", desc = "Debug: Continue" },
				{ "<M-2>", desc = "Debug: Step Over" },
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
