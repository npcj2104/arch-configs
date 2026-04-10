-- ~ / .config / nvim / lua / plugins / oil.lua

return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			-- 1. INTEGRATION
			-- Set to true to replace netrw (default vim explorer) completely
			default_file_explorer = true,

			-- Columns to display (e.g., icons, permissions, size, mtime)
			columns = { "icon" },

			-- 2. VISUALS
			view_options = {
				-- Shows files starting with '.' (like .gitignore or .clang-format)
				show_hidden = true,
			},

			-- 3. KEYMAPS (Inside the Oil buffer)
			keymap_help_label = "Help",
			keymaps = {
				["g?"] = "show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit", -- Open in vertical split
				["<C-h>"] = "actions.select_split", -- Open in horizontal split
				["<C-p>"] = "actions.preview", -- Floating preview of the file
				["<C-c>"] = "actions.close",
				["-"] = "actions.parent", -- Go up one directory
				["_"] = "actions.open_cwd", -- Go to current working directory
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",

				-- CUSTOM ACTION: System Open
				-- Uses the native OS opener to launch files outside of Neovim
				["<leader>o"] = {
					desc = "Open file in default system application",
					callback = function()
						local oil = require("oil")
						local entry = oil.get_cursor_entry()
						if not entry then
							return
						end

						local dir = oil.get_current_dir()
						local full_path = dir .. entry.name

						-- Determine the system opener based on the environment
						local opener
						if vim.fn.has("mac") == 1 then
							opener = "open"
						elseif vim.fn.has("win32") == 1 then
							opener = "start"
						else
							opener = "xdg-open" -- Standard for Linux (your laptop)
						end

						-- Start the process detached so Neovim doesn't wait for it to close
						vim.fn.jobstart({ opener, full_path }, { detach = true })
					end,
				},
			},
		})

		-- 4. GLOBAL SHORTCUT
		-- Pressing '-' in any buffer opens Oil to that file's location.
		-- This is a very intuitive shortcut (think of '-' as going 'up' a level).
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory (Oil)" })
	end,
}
