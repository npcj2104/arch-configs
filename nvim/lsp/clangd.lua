---@brief
--- Configuration for clangd, the LLVM-based language server for C and C++.
--- https://clangd.llvm.org/installation.html

-- Utility: Switch between .c/.cpp and .h/.hpp files.
-- This is a standard workflow in C/C++ development.
local function switch_source_header(bufnr, client)
	local method_name = "textDocument/switchSourceHeader"
	if not client or not client:supports_method(method_name) then
		return vim.notify("Switching source/header is not supported by the current server", vim.log.levels.WARN)
	end

	local params = vim.lsp.util.make_text_document_params(bufnr)
	client:request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			vim.notify("Corresponding source/header file cannot be determined", vim.log.levels.INFO)
			return
		end
		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end

-- Utility: Show detailed symbol information in a floating window.
local function symbol_info(bufnr, client)
	local method_name = "textDocument/symbolInfo"
	if not client or not client:supports_method(method_name) then
		return
	end

	local win = vim.api.nvim_get_current_win()
	local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
	client:request(method_name, params, function(err, res)
		if err or not res or #res == 0 then
			return
		end
		local container = string.format("Container: %s", res[1].containerName or "None")
		local name = string.format("Name: %s", res[1].name or "Unknown")

		vim.lsp.util.open_floating_preview({ name, container }, "markdown", {
			border = "rounded",
			title = " Symbol Info ",
		})
	end, bufnr)
end

---@type vim.lsp.Config
return {
	-- SERVER INVOCATION
	cmd = {
		"clangd",
		"--background-index", -- Index project in the background
		"--clang-tidy", -- Enable clang-tidy diagnostics
		"--header-insertion=iwyu", -- Auto-insert #include using "Include What You Use"
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm", -- Style to use if .clang-format is missing
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		".git",
	},

	-- CAPABILITIES & ENCODING
	-- Clangd prefers utf-16, but Neovim uses utf-8.
	-- This priority list avoids the "multiple different client offset_encodings" warning.
	capabilities = {
		offsetEncoding = { "utf-16", "utf-8" },
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
	},

	-- INITIALIZATION
	on_init = function(client, init_result)
		if init_result.offsetEncoding then
			client.offset_encoding = init_result.offsetEncoding
		end
	end,

	-- ATTACHMENT LOGIC
	on_attach = function(client, bufnr)
		-- Enable Inlay Hints if supported by the Neovim version
		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end

		-- Commands
		vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
			switch_source_header(bufnr, client)
		end, { desc = "Switch between source/header" })

		vim.api.nvim_buf_create_user_command(bufnr, "LspClangdShowSymbolInfo", function()
			symbol_info(bufnr, client)
		end, { desc = "Show detailed symbol info" })
	end,
}
