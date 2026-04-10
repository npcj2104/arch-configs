---@brief
--- Configuration for cssls, the CSS language server extracted from VS Code.
--- Part of the 'vscode-langservers-extracted' suite.
---
--- Install via npm:
--- npm i -g vscode-langservers-extracted

---@type vim.lsp.Config
return {
	-- SERVER INVOCATION
	-- Ensure 'vscode-css-language-server' is in your system PATH.
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },

	-- INITIALIZATION
	init_options = {
		-- Enables the built-in CSS formatter.
		-- If you prefer Prettier, you can set this to false.
		provideFormatter = true,
	},

	-- PROJECT DETECTION
	root_markers = { "package.json", ".git" },

	-- SERVER SETTINGS
	-- These settings allow the server to validate syntax and provide
	-- smart completions based on the specific dialect (CSS/SCSS/Less).
	settings = {
		css = {
			validate = true,
			-- lint = {
			--     unknownAtRules = "ignore" -- Useful if using Tailwind/PostCSS
			-- }
		},
		scss = {
			validate = true,
		},
		less = {
			validate = true,
		},
	},

	-- ATTACHMENT
	-- We use the default capabilities provided by your completion engine
	-- (e.g., blink.cmp or nvim-cmp), which handles snippet support automatically.
	-- on_attach = function(client, bufnr)
	-- Add CSS-specific keybindings or logic here if needed.
	-- end,
}
