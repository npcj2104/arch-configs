---@brief
--- Configuration for StyLua, an opinionated and fast Lua formatter.
--- This uses the built-in LSP support in StyLua to provide formatting.
---
--- Install via cargo, npm, or GitHub releases:
--- cargo install stylua
--- npm i -g @johnnymorganz/stylua-bin
---
--- https://github.com/JohnnyMorganz/StyLua

---@type vim.lsp.Config
return {
	-- SERVER INVOCATION
	-- The '--lsp' flag tells StyLua to act as a language server.
	cmd = { "stylua", "--lsp" },
	filetypes = { "lua" },

	-- PROJECT DETECTION
	-- StyLua will look for these files to determine formatting rules.
	root_markers = {
		".stylua.toml",
		"stylua.toml",
		".editorconfig",
	},

	-- ATTACHMENT LOGIC
	on_attach = function(client, bufnr)
		-- Disable stylua's formatting if you prefer lua_ls to do it,
		-- though usually, stylua is the preferred formatter for Lua.
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true

		-- Optional: Create a buffer-local command to format
		vim.api.nvim_buf_create_user_command(bufnr, "LspStyLuaFormat", function()
			vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
		end, { desc = "Format current buffer with StyLua" })
	end,
}
