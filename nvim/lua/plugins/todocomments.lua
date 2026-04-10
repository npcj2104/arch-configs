-- ~ / .config / nvim / lua / plugins / todocomments.lua

return {
	"folke/todo-comments.nvim",
	-- Load on VimEnter so it's ready as soon as the UI is up
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },

	---@module 'todo-comments'
	---@type TodoOptions
	---@diagnostic disable-next-line: missing-fields
	opts = {
		-- Setting signs to false keeps the gutter clean,
		-- relying on the text highlighting instead.
		signs = false,

		-- You can add custom keywords here if you like
		keywords = {
			FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
			TEST = { icon = "⏲", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		},
	},

	-- Adding keymaps to integrate with your existing navigation
	config = function(_, opts)
		local todo = require("todo-comments")
		todo.setup(opts)

		local map = vim.keymap.set

		-- Jump to the next/previous TODO comment
		map("n", "]t", function()
			todo.jump_next()
		end, { desc = "Next TODO comment" })
		map("n", "[t", function()
			todo.jump_prev()
		end, { desc = "Previous TODO comment" })

		-- Integration with Telescope (Search all TODOs in the project)
		-- This fits perfectly with your <leader>s (search) prefix
		map("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "[S]earch [T]ODOs" })
	end,
}
