-- ~ / .config / nvim / after / plugin / c.lua
--
-- INDENTATION (Linux Kernel Style)
-- Using real tabs (8 chars) is standard for C kernel development.
vim.opt_local.expandtab = false -- Use actual tab characters
vim.opt_local.tabstop = 8 -- Visual width of a tab
vim.opt_local.shiftwidth = 8 -- Size of an indent
vim.opt_local.softtabstop = 8 -- Tab behavior when editing

-- C-INDENTING RULES (cinoptions)
-- :0  -> Don't indent 'case' labels relative to 'switch'
-- (0  -> Align function arguments with the opening parenthesis
-- t0  -> Don't indent return types of functions
-- g0  -> Don't indent C++ scope declarations (public/private)
vim.opt_local.cindent = true
vim.opt_local.cinoptions = ":0,(0,t0,g0"

-- TEXT WRAPPING & FORMATTING
vim.opt_local.textwidth = 80 -- Limit line length to 80 chars
-- 'c': Wrap comments using textwidth
-- 'q': Allow formatting of comments with 'gq'
-- 'n': Recognize numbered lists in comments
-- 'j': Remove comment leaders when joining lines
vim.opt_local.formatoptions = "cqnj"

-- VISUAL GUIDES
-- Draw a vertical line at the 81st column to signal the wrap limit.
vim.opt_local.colorcolumn = "81"

-- UTILITIES
-- Ensures that comment plugins use the standard C block comment style.
vim.opt_local.commentstring = "/* %s */"

-- Optional: Fold based on syntax (useful for large C files)
-- vim.opt_local.foldmethod = "syntax"
