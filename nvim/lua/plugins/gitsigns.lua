-- ~ / .config / nvim / lua / plugins / gitsigns.lua

---@module 'lazy'
---@type LazySpec
return {
	"lewis6991/gitsigns.nvim",
	---@module 'gitsigns'
	---@type Gitsigns.Config
	opts = {
		-- VISUAL CONFIGURATION
		-- Using thinner, cleaner signs for a modern look
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},

		-- Blame line configuration (shows who wrote the code at the end of the line)
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
		},

		-- KEYMAPS & LOGIC
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- NAVIGATION: Jump between hunks (changes)
			-- These automatically fall back to native vim diff jumps if in diff mode
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Jump to next git [c]hange" })

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Jump to previous git [c]hange" })

			-- ACTIONS: Stage, Reset, and Preview
			-- Visual mode mappings allow you to stage/reset specific lines
			map("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git [s]tage hunk" })
			map("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git [r]eset hunk" })

			-- Normal mode mappings
			map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
			map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
			map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
			map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })

			-- UI Overlays
			map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
			map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "git preview hunk [i]nline" })
			map("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "git [b]lame line" })

			-- Diffs: See exactly what changed compared to index or last commit
			map("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index" })
			map("n", "<leader>hD", function()
				gitsigns.diffthis("@")
			end, { desc = "git [D]iff against last commit" })

			-- Quickfix integration: Populate a list with all changes in the file/project
			map("n", "<leader>hQ", function()
				gitsigns.setqflist("all")
			end, { desc = "List all hunk changes" })
			map("n", "<leader>hq", gitsigns.setqflist, { desc = "List hunk changes in file" })

			-- TOGGLES
			map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
			map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "[T]oggle word diff" })

			-- TEXT OBJECT: Allows operations like 'dih' (delete inside hunk) or 'yih' (yank inside hunk)
			map({ "o", "x" }, "ih", gitsigns.select_hunk)
		end,
	},
}
