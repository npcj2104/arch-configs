return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "n",
			desc = "[F]ormat buffer",
		},
	},
	---@module 'conform'
	---@type conform.setupOpts
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Note: Since you want Linux style, we enable format_on_save for C/C++
			-- by removing them from the disable list if you want it automatic.
			local disable_filetypes = {}
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			else
				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" }, -- Assign clang-format to C
			cpp = { "clang-format" }, -- Assign clang-format to C++
		},
		formatters = {
			["clang-format"] = {
				-- Pass the Linux style argument to the CLI tool
				prepend_args = { "--style=Linux" },
				rst = { "rstfmt" },
			},
		},
	},
}
