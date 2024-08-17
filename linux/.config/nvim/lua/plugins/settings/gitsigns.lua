return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				-- Helper functions and varibles
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Actions
				map('n', '<leader>hp', gitsigns.preview_hunk)
				map('n', '<leader>hr', gitsigns.reset_hunk)
				map('n', '<leader>hR', gitsigns.reset_buffer)

				-- Navigation
				map({'n', 'v'}, ']h', function() gitsigns.nav_hunk('next') end)
				map({'n', 'v'}, '[h', function() gitsigns.nav_hunk('prev') end)
			end,
		}
	}
}
