-- ~ / .config / nvim / lua / plugins / lsp.lua

return {
	-- MASON: The Package Manager for LSP/DAP/Linters/Formatters
	{
		"williamboman/mason.nvim",
		cmd = "Mason", -- Only load this plugin when you run the :Mason command
		build = ":MasonUpdate", -- Automatically check for registry updates on install
		opts = {
			ui = {
				border = "rounded", -- Matches your Everforest rounded aesthetic
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- MASON-LSPCONFIG: The Bridge between Mason and Neovim LSP
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				-- ENSURE INSTALLED: Your "Essential Kit"
				-- These will be automatically downloaded on a fresh machine.
				ensure_installed = {
					"clangd", -- C/C++ (Linux style as per your conform setup)
					"lua_ls", -- Neovim config development
					"basedpyright", -- Modern Python typing
					"vtsls", -- Advanced TS/JS (configured in your vtsls.lua)
					"html", -- Web dev
					"cssls", -- Styling
				},

				-- This ensures that any LSP you try to use is installed first.
				automatic_installation = true,
			})
		end,
	},
}
