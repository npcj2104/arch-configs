-- ~ / .config / nvim / lua / plugins / mini.lua

return {
	-- Collection of various small independent plugins/modules
	-- mini.nvim is extremely fast because it's written in highly optimized Lua.
	"echasnovski/mini.nvim",
	config = function()
		-- 1. MINI.AI (Advanced Text Objects)
		-- Extends Vim's 'a' (around) and 'i' (inside) functionality.
		-- It adds support for "Next" and "Last" objects.
		--
		-- Examples:
		-- - va)  - [V]isually select [A]round [)]paren
		-- - yinq - [Y]ank [I]nside [N]ext [Q]uote (Very useful!)
		-- - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- 2. MINI.SURROUND (Surroundings Management)
		-- Allows you to quickly add, delete, or replace brackets/quotes.
		--
		-- Commands:
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'    - [S]urround [D]elete [']quotes
		-- - sr)'   - [S]urround [R]eplace [)] with [']
		require("mini.surround").setup()

		-- 3. OPTIONAL MODULES (For your consideration)
		-- You can add more mini modules here as you grow.
		-- For example:
		-- require('mini.comment').setup() -- Simple and fast commenting
		-- require('mini.indentscope').setup() -- Visual scope lines
	end,
}
