return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "FelipeLema/cmp-async-path" }
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "async_path" }
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-k>"] = cmp.mapping.scroll_docs(-4),
					["<C-j>"] = cmp.mapping.scroll_docs(4),
					["<C-l>"] = cmp.mapping.complete(),
					["<C-q>"] = cmp.mapping.abort(),
					["<TAB>"] = cmp.mapping.confirm({ select = true })
				})
			})

			-- WARNING: Maybe we have to add some extra config here to properly
			--			enable the 'nvim_lsp' source.

			-- WARNING: Maybe we have to add some extra config here to properly
			--			enable the 'async_path' source.

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend(
				"force",
				capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)
		end
	}
}
