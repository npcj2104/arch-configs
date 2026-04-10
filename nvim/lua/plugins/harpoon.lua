return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		-- 1. Essential Keymaps
		-- Add current file to Harpoon list
		vim.keymap.set("n", "<leader>h", function()
			harpoon:list():add()
		end, { desc = "Harpoon: Add file" })

		-- Open the Harpoon menu UI to see/reorder your files
		vim.keymap.set("n", "<leader>m", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon: Menu" })

		-- 2. Your Request: Leader + 1-9 to switch files
		-- This is the fastest way to jump between C header and source files
		for i = 1, 9 do
			vim.keymap.set("n", "<leader>" .. i, function()
				harpoon:list():select(i)
			end, { desc = "Harpoon: Select file " .. i })
		end
	end,
}
