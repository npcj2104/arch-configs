-- ~ / .config / nvim / lua / plugins / telescope.lua

return {
	{
		"nvim-telescope/telescope.nvim",
		-- Dependencies provide the utility functions, UI overrides, and speed boosts
		dependencies = {
			-- Plenary: A library of Lua functions that many plugins rely on
			{ "nvim-lua/plenary.nvim" },

			-- UI-Select: Forces native Neovim selection menus (like code actions)
			-- to use Telescope's searchable interface.
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- FZF Native: A C-port of the fzf algorithm.
			-- It makes searching significantly faster and smarter (typo resistance).
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					-- 1. STABILITY & DISPLAY
					-- 'truncate' prevents crashes by shortening long file paths
					-- that can sometimes overflow the buffer logic in certain environments.
					path_display = { "truncate" },

					-- Enable Treesitter for syntax highlighting inside the preview window
					preview = {
						treesitter = true,
					},

					-- 2. UI & LAYOUT
					layout_config = {
						horizontal = {
							prompt_position = "top", -- Put the search bar at the top
							preview_width = 0.55, -- Give the preview a bit more than half the screen
						},
					},

					-- Start typing at the top and move downwards
					sorting_strategy = "ascending",
				},
			})

			-- Load extensions after setup
			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")

			-- 3. KEYMAPS (Built-in Pickers)
			local builtin = require("telescope.builtin")

			-- General Search
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })

			-- Code/Text Search
			vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })

			-- Utility Search
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files" })
			vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands" })

			-- Buffer Management
			-- Double-Leader is a very fast shortcut for switching between open files
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		end,
	},
}
