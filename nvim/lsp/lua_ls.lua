---@brief
--- Configuration for lua-language-server, the gold standard for Lua development.
--- Optimized for Neovim config development and general Lua scripting.
---
--- Install via your package manager or:
--- https://github.com/luals/lua-language-server

local root_markers = {
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
	".git",
}

---@type vim.lsp.Config
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	-- Smart root detection for different Neovim versions
	root_markers = vim.fn.has("nvim-0.11") == 1 and root_markers or root_markers,

	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (Neovim uses LuaJIT).
				version = "LuaJIT",
			},
			diagnostics = {
				-- 1. SILENCE THE 'VIM' WARNING
				-- This tells the server that 'vim' is a valid global variable.
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files for autocompletion.
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- Prevents annoying 'Do you want to configure your workspace?' prompts
			},
			telemetry = {
				enable = false,
			},
			hint = {
				enable = true, -- Enables Inlay Hints for Lua
				semicolon = "Disable",
				arrayIndex = "Disable",
			},
			codeLens = {
				enable = true,
			},
		},
	},

	-- This on_init function is a 'portable' way to handle Neovim-specific
	-- development environments vs. general Lua projects.
	on_init = function(client)
		local path = client.workspace_folders and client.workspace_folders[1].name
		if not path then
			return
		end

		-- If we are NOT in our nvim config folder and a .luarc exists,
		-- let the project-specific config take over.
		if
			path ~= vim.fn.stdpath("config")
			and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
		then
			return
		end

		-- Otherwise, ensure Neovim development support is injected.
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				path = { "lua/?.lua", "lua/?/init.lua" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					-- Add your own custom paths here if needed
				},
			},
		})
	end,
}
