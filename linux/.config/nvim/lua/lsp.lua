-- LSP keybinds
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		-- Helper function (just to make it shorter)
		local nmap = function(bind, action)
			vim.keymap.set('n', bind, action, { buffer = event.buf })
		end

		nmap('<leader>ca', vim.lsp.buf.code_action)
		nmap('<F2>', vim.lsp.buf.rename)

		nmap('K', vim.lsp.buf.hover)
		nmap('<C-k>', vim.lsp.buf.signature_help)

		nmap('gd', vim.lsp.buf.definition)
	end
})

-- Diagnostic keybinds
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
