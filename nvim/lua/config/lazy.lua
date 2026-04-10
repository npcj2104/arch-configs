-- ~ / .config / nvim / lua / core / lazy.lua

-- 1. BOOTSTRAP: Automatically install lazy.nvim if it's missing
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none", -- Only clone the necessary files (saves time/bandwidth)
		"--branch=stable", -- Stick to the latest stable release
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- 2. SETUP: Load your plugins and configure lazy's behavior
require("lazy").setup({
	spec = {
		-- This will recursively import everything in the 'lua/plugins/' directory
		{ import = "plugins" },
	},

	-- Default colorscheme to use during plugin installation/updates
	install = { colorscheme = { "habamax" } },

	-- Plugin Update Checks
	checker = {
		enabled = true, -- Automatically check for updates
		notify = false, -- Don't annoy me with a notification every time
	},

	-- UI and Performance
	ui = {
		-- Rounded borders look much better on modern terminals
		border = "rounded",
	},

	performance = {
		rtp = {
			-- Disable some built-in Vim plugins that you likely don't need
			-- This speeds up Neovim's startup time slightly.
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				"netrwPlugin", -- Use a plugin like nvim-tree or oil.nvim instead
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
