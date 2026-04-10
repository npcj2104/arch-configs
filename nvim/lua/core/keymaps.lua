-- ~ / .config / nvim / lua / core / keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- GENERAL UTILITIES
-- Comfort: Exit insert mode without reaching for Esc
keymap("i", "jk", "<Esc>", opts)
keymap("i", "jj", "<Esc>", opts)

-- Search: Clear highlights easily
keymap("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", opts)
keymap("n", "<Leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- "SPACE + HJKL" SCROLLING
-- This allows you to scroll the view without moving the cursor's
-- relative position on the screen, using your Leader key.
keymap("n", "<Leader>j", "<C-e>", { desc = "Scroll down (one line)" })
keymap("n", "<Leader>k", "<C-y>", { desc = "Scroll up (one line)" })
keymap("n", "<Leader>h", "zh", { desc = "Scroll view left" })
keymap("n", "<Leader>l", "zl", { desc = "Scroll view right" })

-- WINDOW MANAGEMENT
-- Splitting
keymap("n", "<Leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<Leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<Leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<Leader>sx", ":close<CR>", { desc = "Close current split" })

-- Navigation: Smooth jumping between splits
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- TERMINAL MODE
-- Open terminal in a horizontal split at the bottom
keymap("n", "<Leader>te", ":botright sp | terminal<CR>i", { desc = "Open Terminal (Bottom)" })

-- Escape Terminal Mode with standard keys
keymap("t", "<Esc>", [[<C-\><C-n>]], opts)
keymap("t", "jk", [[<C-\><C-n>]], opts)

-- Navigation within Terminal (Exit-and-Move)
keymap("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
keymap("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

-- SYSTEM CLIPBOARD
-- Yank (Copy)
keymap({ "n", "v" }, "<leader>yy", '"+y', { desc = "Copy to system clipboard" })
keymap("n", "<leader>Y", '"+yg_', { desc = "Copy to end of line to clipboard" })

-- Paste
keymap({ "n", "v" }, "<leader>pp", '"+p', { desc = "Paste from system clipboard" })
keymap("n", "<leader>P", '"+P', { desc = "Paste before cursor from clipboard" })

-- Delete without losing register content
-- This allows you to delete text without it replacing what you just copied.
keymap({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
