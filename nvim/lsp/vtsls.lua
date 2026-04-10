---@brief
--- Configuration for vtsls, a high-performance TypeScript LSP.
--- Better monorepo support and more features than the standard ts_ls.
---
--- Install via npm:
--- npm install -g @vtsls/language-server

---@type vim.lsp.Config
return {
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},

	-- INITIALIZATION
	init_options = {
		hostInfo = "neovim",
		-- Enables advanced refactoring features
		preferences = {
			importModuleSpecifierPreference = "non-relative",
			includeInlayParameterNameHints = "all",
			includeInlayVariableTypeHints = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
		},
	},

	-- SERVER SETTINGS
	settings = {
		typescript = {
			updateImportsOnRename = "always",
			suggest = {
				completeFunctionCalls = true,
			},
			inlayHints = {
				parameterNames = { enabled = "all" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
		},
	},

	-- ROOT DETECTION & DENO EXCLUSION
	-- Ensures vtsls doesn't start in Deno projects.
	root_dir = function(bufnr, on_dir)
		local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "package.json", ".git" }

		local project_root = vim.fs.root(bufnr, root_markers)
		local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" })

		-- If Deno is detected and is closer to the file than the Node root, skip vtsls
		if deno_root and (not project_root or #deno_root >= #project_root) then
			return nil
		end

		on_dir(project_root or vim.fn.getcwd())
	end,

	-- 4. ATTACHMENT COMMANDS
	on_attach = function(client, bufnr)
		-- Enable Inlay Hints (Neovim 0.10+)
		if vim.lsp.inlay_hint then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end

		-- Useful vtsls-specific commands
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "TS: " .. desc })
		end

		map("n", "<leader>tso", "VtslsOrganizeImports", "Organize Imports")
		map("n", "<leader>tsf", "VtslsFixAll", "Fix All Diagnostics")
		map("n", "<leader>tsr", "VtslsRenameFile", "Rename File")
		map("n", "<leader>tsm", "VtslsMoveToFile", "Move Symbol to File")
	end,
}
