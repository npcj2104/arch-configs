-- ~ / .config / nvim / lua / plugins / aerial.lua

return {
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy", -- Load when needed to keep startup fast
		config = function()
			require("aerial").setup({
				-- Priority: use LSP if available, then Treesitter
				backends = { "lsp", "treesitter", "markdown", "man" },

				layout = {
					min_width = 28,
					default_direction = "right", -- Sidebar on the right
					placement = "window",
					preserve_equality = true, -- Keep window sizes stable when toggling
				},

				-- Visuals
				show_guides = true,
				guides = {
					mid_item = "├─",
					last_item = "└─",
					nested_top = "│ ",
					whitespace = "  ",
				},

				-- Behavior
				attach_mode = "global", -- Follow the cursor as you switch buffers
				highlight_on_hover = true,
				update_events = "TextChanged,InsertLeave", -- Keep the outline fresh

				-- Icons (matches your devicons theme)
				icons = {},

				-- Filtering symbols
				filter_kind = {
					"Class",
					"Constructor",
					"Enum",
					"Function",
					"Interface",
					"Module",
					"Method",
					"Struct",
				},
			})

			-- KEYMAPS
			local map = vim.keymap.set

			-- Toggle the sidebar
			map("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Outline (Aerial)" })

			-- Symbol Navigation (The "{" and "}" keys are great for this)
			map("n", "{", "<cmd>AerialPrev<CR>", { desc = "Jump to Previous Symbol" })
			map("n", "}", "<cmd>AerialNext<CR>", { desc = "Jump to Next Symbol" })

			-- Optional: Integration with Telescope if you use it
			map("n", "<leader>as", "<cmd>Telescope aerial<CR>", { desc = "Search Symbols (Fuzzy)" })
		end,
	},
}
