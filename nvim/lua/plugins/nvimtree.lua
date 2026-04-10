-- ~ / .config / nvim / lua / plugins / nvimtree.lua

return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false, -- Load immediately so it's ready when you open Nvim
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				-- VISUALS & LAYOUT
				sort_by = "case_sensitive",
				view = {
					width = 30,
					side = "left", -- Classic IDE placement
				},
				renderer = {
					-- group_empty: turns 'src/main/java/com' into one line if folders are empty
					group_empty = true,
					highlight_git = true,
					-- Match your rounded UI aesthetic
					indent_markers = {
						enable = true,
						inline_arrows = true,
						icons = {
							corner = "└",
							edge = "│",
							item = "│",
							none = " ",
						},
					},
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						},
					},
				},

				-- BEHAVIOR & FILTERS
				filters = {
					-- Hide system files you rarely edit (like .DS_Store or .git)
					dotfiles = false,
					custom = { "node_modules", "\\.cache" },
				},

				-- SYNCING: The "Where am I?" feature
				update_focused_file = {
					enable = true, -- Auto-reveals the current file in the tree
					update_root = false, -- Keeps the project root stable
				},

				-- ACTIONS
				-- Standard keymaps inside the tree:
				-- 'o' or 'Enter' to open
				-- 'a' to add a file, 'd' to delete, 'r' to rename
				actions = {
					open_file = {
						quit_on_open = false, -- Keep tree open after picking a file
						window_picker = { enable = true },
					},
				},
			})

			-- GLOBAL KEYMAP
			-- Toggle the explorer with Leader + e
			vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {
				desc = "Toggle File Explorer",
				silent = true,
			})
		end,
	},
}
