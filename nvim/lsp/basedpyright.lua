---@brief
--- Configuration for basedpyright, a formidable fork of pyright with
--- improved type checking and better performance.
--- https://github.com/DetachHead/basedpyright

-- Utility: Dynamically update the pythonPath for the active LSP client.
-- Useful when switching virtual environments without restarting Neovim.
local function set_python_path(command)
	local path = command.args
	local clients = vim.lsp.get_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = "basedpyright",
	})

	for _, client in ipairs(clients) do
		if client.settings then
			client.settings.python = vim.tbl_deep_extend("force", client.settings.python or {}, { pythonPath = path })
		else
			client.config.settings =
				vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
		end
		-- Notify the server that the configuration has changed
		client:notify("workspace/didChangeConfiguration", { settings = client.settings or client.config.settings })
	end
end

---@type vim.lsp.Config
return {
	-- Ensure 'basedpyright-langserver' is installed via npm/pip and in your PATH.
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyrightconfig.json",
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				-- "standard" is balanced. "all" is for strict type safety.
				typeCheckingMode = "standard",
				-- We leave useLibraryCodeForTypes unset to allow project-level overrides.
			},
		},
		python = {
			-- Enables modern 'Inlay Hints' for variable types and returns.
			-- Toggle with vim.lsp.inlay_hint.enable() if your Neovim version supports it.
			analysis = {
				inlayHints = {
					variableTypes = true,
					functionReturnTypes = true,
					callArgumentNames = true,
					pytestParameters = true,
				},
			},
		},
	},
	on_attach = function(client, bufnr)
		-- Command: LspPyrightOrganizeImports
		-- Manually trigger import sorting if not using an external formatter like Ruff.
		vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
			local params = {
				command = "basedpyright.organizeimports",
				arguments = { vim.uri_from_bufnr(bufnr) },
			}
			-- Using direct request because this command is often marked as 'private' by the server.
			client.request("workspace/executeCommand", params, nil, bufnr)
		end, { desc = "Organize Python Imports" })

		-- Command: LspPyrightSetPythonPath <path>
		-- Manually point the LSP to a specific python executable (e.g., in a .venv).
		vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
			desc = "Reconfigure basedpyright with the provided python path",
			nargs = 1,
			complete = "file",
		})
	end,
}
