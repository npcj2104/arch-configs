---@brief
--- Configuration for html-languageserver, extracted from VS Code.
--- Handles HTML structures, as well as embedded CSS and JavaScript.
---
--- Install via npm:
--- npm i -g vscode-langservers-extracted

---@type vim.lsp.Config
return {
	-- SERVER INVOCATION
	cmd = { "vscode-html-language-server", "--stdio" },

	-- Added 'xhtml' and 'templ' for broader compatibility
	filetypes = { "html", "xhtml", "templ" },

	-- PROJECT DETECTION
	root_markers = { "package.json", ".git" },

	-- INITIALIZATION OPTIONS
	-- These ensure the server knows how to handle code inside <style> and <script> tags.
	init_options = {
		provideFormatter = true,
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		configurationSection = { "html", "css", "javascript" },
	},

	-- SERVER SETTINGS
	settings = {
		html = {
			format = {
				templating = true,
				wrapLineLength = 120,
				wrapAttributes = "auto",
			},
			hover = {
				documentation = true,
				references = true,
			},
		},
	},

	-- ATTACHMENT
	-- on_attach = function(client, bufnr)
	-- HTML-specific logic can go here (e.g., auto-tag closing is often
	-- handled by plugins like nvim-ts-autotag).
	-- end,
}
