-- ~ / .config / nvim / lua / plugins / blinkcmp.lua

return {
	"saghen/blink.cmp",
	-- Link friendly-snippets for a massive collection of out-of-the-box snippets
	dependencies = { "rafamadriz/friendly-snippets" },

	version = "v0.*", -- Use latest stable release

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- MAPPINGS
		-- 'default' is great, but we can customize it to be even more efficient.
		keymap = {
			preset = "default",
			-- Map <Tab> and <S-Tab> for snippet navigation
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},

		-- APPEARANCE
		appearance = {
			nerd_font_variant = "mono",
			-- Use the same icons as your LSP/Devicons
			kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈚",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰅲",
			},
		},

		-- COMPLETION BEHAVIOR
		completion = {
			-- Automatically add parentheses when accepting a function/method
			accept = { auto_brackets = { enabled = true } },

			-- Show documentation after a short delay
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				window = { border = "rounded" },
			},

			-- Customize the menu appearance
			menu = {
				border = "rounded",
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
				},
			},
		},

		-- SIGNATURE HELP (Floating window for function arguments)
		signature = {
			enabled = true,
			window = { border = "rounded" },
		},

		-- SOURCES
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- Use the Rust fuzzy matcher for maximum speed
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
