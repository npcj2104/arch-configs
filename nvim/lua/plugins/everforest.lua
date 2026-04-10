-- ~ / .config / nvim / lua / plugins / everforest.lua

return {
	{
		"neanias/everforest-nvim",
		version = false,
		priority = 1000, -- Load this before all other plugins
		lazy = false,
		config = function()
			require("everforest").setup({
				-- "hard" provides the most contrast for a dark green look
				background = "hard",
				-- "dim" makes floating windows slightly darker than the main editor
				float_style = "dim",
				disable_italic_comments = false,
				ui_contrast = "high",

				-- CUSTOM COLORS: Pushing the background toward Dark Green
				-- bg0 is the main background color.
				-- Standard Hard bg0 is #272e33. We'll shift it to a deep forest hex.
				on_highlights = function(hl, palette)
					-- You can experiment with these hex codes:
					-- #1e2320 (Deepest Forest)
					-- #202820 (Balanced Dark Green)
					local dark_green = "#272e33"

					hl.Normal = { bg = dark_green }
					hl.NormalFloat = { bg = palette.bg1 } -- Keep floats slightly lighter
					hl.SignColumn = { bg = dark_green }
					hl.EndOfBuffer = { fg = dark_green } -- Hide the '~' at the end of files
				end,
			})

			-- Apply the theme
			vim.o.background = "dark"
			vim.cmd([[colorscheme everforest]])
		end,
	},
}
