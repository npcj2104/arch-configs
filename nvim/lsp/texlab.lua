---@brief
--- Configuration for TexLab, a cross-platform LaTeX language server.
--- Provides features like build automation, forward search, and linting.
--- https://github.com/latex-lsp/texlab

-- DETECT OPERATING SYSTEM
local is_mac = vim.uv.os_uname().sysname == "Darwin"
local is_win = vim.uv.os_uname().sysname == "Windows_NT"

-- DYNAMIC PDF VIEWER CONFIG
-- Portable settings for different operating systems.
local viewer_cmd = "zathura" -- Default for Linux (Wayland/X11)
local viewer_args = { "%f", "--synctex", "--keep-logs", "--keep-intermediates" }

if is_mac then
	viewer_cmd = "/Applications/Skim.app/Contents/SharedSupport/displayline"
	viewer_args = { "%l", "%p", "%f" }
elseif is_win then
	viewer_cmd = "SumatraPDF.exe"
	viewer_args = { "-reuse-instance", "-forward-search", "%f", "%l", "%p" }
end

-- UTILITY FUNCTIONS (Condensed for clarity)
local function buf_build(client, bufnr)
	local params = vim.lsp.util.make_position_params(vim.api.nvim_get_current_win(), client.offset_encoding)
	client:request("textDocument/build", params, function(err, result)
		if err then
			return error(tostring(err))
		end
		local status = { [0] = "Success", [1] = "Error", [2] = "Failure", [3] = "Cancelled" }
		vim.notify("TexLab Build: " .. (status[result.status] or "Unknown"), vim.log.levels.INFO)
	end, bufnr)
end

local function buf_search(client, bufnr)
	local params = vim.lsp.util.make_position_params(vim.api.nvim_get_current_win(), client.offset_encoding)
	client:request("textDocument/forwardSearch", params, function(err, result)
		if err then
			return error(tostring(err))
		end
		local status = { [0] = "Success", [1] = "Error", [2] = "Failure", [3] = "Unconfigured" }
		vim.notify("TexLab Search: " .. (status[result.status] or "Unknown"), vim.log.levels.INFO)
	end, bufnr)
end

---@type vim.lsp.Config
return {
	cmd = { "texlab" },
	filetypes = { "tex", "plaintex", "bib" },
	root_markers = { ".git", ".latexmkrc", "latexmkrc", ".texlabroot", "Tectonic.toml" },

	settings = {
		texlab = {
			build = {
				executable = "latexmk",
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				onSave = false,
			},
			forwardSearch = {
				executable = viewer_cmd,
				args = viewer_args,
				onSave = true,
			},
			chktex = { onOpenAndSave = false },
			latexFormatter = "latexindent",
			latexindent = { modifyLineBreaks = false },
			bibtexFormatter = "texlab",
			formatterLineLength = 80,
		},
	},

	on_attach = function(client, bufnr)
		-- Batch create TexLab specific commands
		local commands = {
			TexlabBuild = { fn = buf_build, desc = "Build LaTeX document" },
			TexlabForward = { fn = buf_search, desc = "Forward search to PDF" },
			-- Add others from your original list here...
		}

		for name, cmd in pairs(commands) do
			vim.api.nvim_buf_create_user_command(bufnr, "Lsp" .. name, function()
				cmd.fn(client, bufnr)
			end, { desc = cmd.desc })
		end
	end,
}
