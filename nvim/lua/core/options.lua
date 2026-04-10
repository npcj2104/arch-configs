-- ~ / .config / nvim / lua / core / options.lua

-- 1. LEADER KEYS (Must be set before Lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- 2. LINE NUMBERS & NAVIGATION
opt.number = true -- Absolute line number at cursor
opt.relativenumber = true -- Relative numbers for easy jumping (5j, 10k)
opt.scrolloff = 10 -- Keep 10 lines visible above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor

-- 3. INDENTATION (Standard Defaults)
-- Note: ftplugins (like your c.lua) will override these for specific languages.
opt.expandtab = true -- Convert tabs to spaces
opt.shiftwidth = 2 -- Indents are 2 spaces
opt.tabstop = 2 -- Visual width of a tab
opt.softtabstop = 2 -- Number of spaces a <Tab> counts for while editing

-- 4. VISUALS & COLORS
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.cursorline = true -- Highlight the text line under the cursor
opt.colorcolumn = "80" -- Vertical ruler for standard code width
opt.list = true -- Show invisible characters (tabs, trailing spaces)
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.signcolumn = "yes" -- Always show the sign column (prevents "flicker" with LSP)

-- 5. SEARCH BEHAVIOR
opt.ignorecase = true -- Ignore case in search patterns...
opt.smartcase = true -- ...unless the pattern contains an uppercase letter
opt.hlsearch = true -- Highlight all matches of the last search
opt.incsearch = true -- Show matches as you type

-- 6. SYSTEM & PERSISTENCE
opt.mouse = "a" -- Enable mouse support for all modes
opt.splitright = true -- Vertical splits open to the right
opt.splitbelow = true -- Horizontal splits open below
opt.undofile = true -- Enable persistent undo (saves across restarts)
opt.updatetime = 250 -- Faster completion and diagnostic display
opt.timeoutlen = 300 -- Time to wait for a mapped sequence (ms)

-- 7. CLIPBOARD PORTABILITY
-- Sync with system clipboard only if we are in a graphical environment.
if vim.fn.has("clipboard") == 1 then
	opt.clipboard = "unnamedplus"
end

-------------------------------------------------------------------------------
-- Specialized Logic & Autocommands
-------------------------------------------------------------------------------

-- Highlight on Yank: Visual feedback when copying text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- Auto-wrap prose for documentation
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.textwidth = 80
		-- 't': auto-wrap text, 'c': wrap comments, 'q': allow 'gq' formatting
		vim.opt_local.formatoptions:append("tcq")
	end,
})

-- Clear search highlight on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- DIAGNOSTICS CONFIGURATION
-- This controls how Neovim shows you errors, warnings, and hints from LSP.
vim.diagnostic.config({
	-- Virtual Lines: This is a modern UI feature.
	-- Instead of just a symbol in the gutter, it can show the error
	-- message directly under the line of code you are currently on.
	virtual_lines = { current_line = true },

	-- Other common diagnostic settings for a clean look:
	virtual_text = false, -- Disable standard virtual text if using virtual lines
	signs = true, -- Keep the icons in the sign column (gutter)
	underline = true, -- Underline the specific code causing the issue
	update_in_insert = false, -- Don't yell at you while you're still typing
	severity_sort = true, -- Prioritize showing Errors over Warnings
})
