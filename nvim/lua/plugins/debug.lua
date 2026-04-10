-- ~ / .config / nvim / lua / plugins / debug.lua

return {
	-- nvim-dap is the Debug Adapter Protocol client for Neovim
	"mfussenegger/nvim-dap",

	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		-- Installs the actual debug adapters (like codelldb)
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},

	-- KEYMAPPINGS
	-- Designed for laptop use where function keys (F5-F12) might be awkward
	keys = {
		-- Alt + 1-4 for standard debugging flow
		{
			"<M-1>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/Continue",
		},
		{
			"<M-2>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step Over",
		},
		{
			"<M-3>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<M-4>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Out",
		},

		-- Breakpoint management
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>B",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Debug: Set Breakpoint",
		},

		-- Alt + 5 for manual UI control
		{
			"<M-5>",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: Toggle UI",
		},
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Bridge between Mason and DAP to ensure adapters are installed and configured
		require("mason-nvim-dap").setup({
			-- Automatically install adapters configured in the 'handlers' or 'ensure_installed'
			automatic_installation = true,

			-- Can be used to provide custom configurations for specific adapters
			handlers = {},

			-- Pre-install codelldb for C/C++/Rust debugging
			ensure_installed = {
				"codelldb",
			},
		})

		-- UI APPEARANCE SETUP
		dapui.setup({
			-- Set the icons used in the sidebar and floating windows
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- AUTOMATION: Open the UI automatically when a session starts
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open

		-- AUTOMATION: Close the UI automatically when a session ends
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- C/C++ CONFIGURATION
		-- This defines how Neovim talks to codelldb for .c files
		dap.configurations.c = {
			{
				name = "Launch file",
				type = "codelldb", -- Matches the adapter installed via Mason
				request = "launch",
				-- Prompts you for the executable path (e.g., ./a.out)
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = vim.fn.getcwd(),
				stopOnEntry = false, -- Set to true if you want to pause at the start of main()
				terminal = "integrated", -- Uses Neovim's internal terminal for I/O
			},
		}
	end,
}
