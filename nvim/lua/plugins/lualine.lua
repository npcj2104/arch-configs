-- ~ / .config / nvim / lua / plugins / lualine.lua

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					-- 1. THEME & STYLE
					-- Automatically inherits colors from your Everforest colorscheme
					theme = "everforest",

					-- Modern Powerline separators (rounded/angled)
					-- Note: These require a Nerd Font to display correctly
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },

					-- 2. CLEANLINESS
					-- Disable the statusline in utility windows like the file tree or code outline
					disabled_filetypes = {
						statusline = { "NvimTree", "aerial", "alpha" },
					},

					-- Enable global statusline (one single bar at the bottom instead of one per split)
					-- This is standard in modern Neovim for a cleaner look.
					globalstatus = true,
				},

				-- 3. LAYOUT (A-Z)
				-- Sections are ordered from left (a) to right (z)
				sections = {
					-- Mode: NORMAL, INSERT, VISUAL (with a rounded left edge)
					lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },

					-- Git Info: Branch, Diff statistics, and LSP Diagnostics
					lualine_b = {
						"branch",
						"diff",
						{ "diagnostics", sources = { "nvim_diagnostic" } },
					},

					-- Filename: Shows relative path (folder/file.c) which is crucial for C projects
					lualine_c = {
						{ "filename", path = 1, symbols = { modified = " ●", readonly = " 󰌾" } },
					},

					-- File Metadata: Encoding, Format (Unix/Dos), and Language Icon
					lualine_x = {
						"encoding",
						"fileformat",
						"filetype",
					},

					-- Progress: Percentage through the file
					lualine_y = { "progress" },

					-- Location: Line and Column (with a rounded right edge)
					lualine_z = {
						{ "location", separator = { right = "" }, left_padding = 2 },
					},
				},

				-- 4. INACTIVE WINDOWS
				-- Simpler layout for split windows that are not currently focused
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
