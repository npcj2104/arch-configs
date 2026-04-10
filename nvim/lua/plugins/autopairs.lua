-- ~ / .config / nvim / lua / plugins / autopairs.lua

return {
	"windwp/nvim-autopairs",
	-- Load on InsertEnter for a fast startup
	event = "InsertEnter",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true, -- Use Treesitter to verify context
			ts_config = {
				lua = { "string", "source" }, -- Don't add pairs in lua strings
				javascript = { "template_string" },
				java = false, -- Don't check treesitter on java
			},
			-- Disable autopairs if the next character is alphanumeric
			-- (Prevents pairs from triggering when editing in the middle of a word)
			check_ts = true,
			enable_check_bracket_line = true,

			-- FastWrap: A "pro" feature
			-- Press <M-e> (Alt+e) to wrap the character under cursor with the pair
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%)%>%]%]%}%,]]=],
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		})
	end,
}
