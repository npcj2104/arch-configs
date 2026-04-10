return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			-- size can be a number or a function
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<leader>tt]], -- The keymap to toggle
			hide_numbers = true, -- hide number column in terminal buffers
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = false, -- whether the open mapping applies in insert mode
			terminal_mappings = true, -- whether the open mapping applies in the opened terminals
			persist_size = true,
			direction = "vertical", -- This sets the default to a vertical split
			close_on_exit = true, -- close the terminal window when the process exits
			shell = vim.o.shell, -- change the default shell
		})
	end,
}
