-- ~ / .config / nvim / after / plugin / rst.lua

-- INDENTATION (Sphinx & Kernel Standards)
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 3 -- Standard for Kernel documentation
vim.opt_local.softtabstop = 3
vim.opt_local.tabstop = 8 -- Kept at 8 for visual consistency

-- TEXT WRAPPING & LINE LIMITS
vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = "81" -- Visual "hard wall" guide
vim.opt_local.wrap = true -- Enable soft-wrapping for long lines
vim.opt_local.breakindent = true -- Maintain indent level on soft-wrapped lines

-- FORMATTING BEHAVIOR (formatoptions)
-- 't': Auto-wrap text using textwidth
-- 'q': Allow formatting of comments/blocks with 'gq'
-- 'c': Auto-wrap comments (useful for literal blocks)
-- 'n': Recognize numbered lists
-- 'j': Smart joining of lines (removes comment leaders)
vim.opt_local.formatoptions = "tqcnj"

-- WRITING UTILITIES
vim.opt_local.spell = true -- Enable spellcheck for documentation
vim.opt_local.spelllang = "en_us" -- Set preferred language

-- DIAGNOSTICS & UI
-- Shows diagnostic messages in virtual lines for easier doc debugging.
-- Note: Ensure your LSP or linter supports virtual_lines.
vim.diagnostic.config({
	virtual_lines = { current_line = true },
})

-- Conceal: Hides markers like *asterisks* or `backticks` for a cleaner look.
-- Set to 0 if you prefer to always see the raw syntax.
vim.opt_local.conceallevel = 2
