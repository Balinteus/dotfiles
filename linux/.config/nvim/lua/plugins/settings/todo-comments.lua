return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
			keywords = {
				TODO = { icon = "☑", color = "info" },
				WARN = { icon = "⚠", color = "warning", alt = { "WARNING" } },
			},
			merge_keywords = false,
			highlight = {
				multiline = true,
				before = "fg",
				after = "fg"
			},
			colors = {
				info = { "#9BB327", "DiagnosticInfo" }
			}
		}
	}
}
