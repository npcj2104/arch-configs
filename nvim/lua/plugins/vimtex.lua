-- ~ / .config / nvim / lua / plugins / vimtex.lua

return {
	{
		"lervag/vimtex",
		-- VimTeX is unique: it manages its own lazy loading based on filetype (.tex).
		-- Setting lazy = false ensures its internal logic can trigger correctly.
		lazy = false,

		init = function()
			-- VIEWING CONFIGURATION
			-- Zathura is a lightweight, keyboard-centric PDF viewer (perfect for Linux).
			vim.g.vimtex_view_method = "zathura"

			-- COMPILATION CONFIGURATION
			-- Tectonic is a modern, self-contained LaTeX engine.
			-- It automatically downloads missing packages—a huge time saver!
			vim.g.vimtex_compiler_method = "tectonic"

			-- Automatically clean up auxiliary files (like .log, .aux) when closing Neovim.
			-- Since Tectonic is used, this keeps your workspace very clean.
			vim.g.vimtex_compiler_clean_on_exit = 1

			-- INTERFACE & BEHAVIOR
			-- Disable the quickfix window from popping up automatically on warnings.
			-- It will still open for actual compilation errors.
			vim.g.vimtex_quickfix_mode = 0

			-- Set the symbol used for the VimTeX "Table of Contents" (TOC)
			vim.g.vimtex_toc_config = {
				name = "TOC",
				layers = { "content", "todo", "include" },
				split_width = 30,
				todo_sorted = 0,
				show_help = 1,
				show_numbers = 1,
			}
		end,
	},
}
