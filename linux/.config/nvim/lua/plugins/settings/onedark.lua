return {
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		init = function() vim.cmd.colorscheme("onedark") end,
		opts = {
			style = "deep",
			highlights = {
				["LineNr"] = { fg = "#858FA2" },
				["CursorLineNr"] = { fmt = "bold" }
			}
		}
	}
}
