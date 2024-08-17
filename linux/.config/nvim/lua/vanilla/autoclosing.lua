-- Auto-closing the vanilla way
local symbolsToAutoClose = { '\'', '"', '`' }
for i=1,#symbolsToAutoClose do
	vim.keymap.set(
		'i',
		string.format("%s", symbolsToAutoClose[i]),
		string.rep(string.format("%s", symbolsToAutoClose[i]), 2).."<left>"
	)
end

vim.keymap.set('i', '(', "()<left>")
vim.keymap.set('i', '{', "{}<left>")
vim.keymap.set('i', '[', "[]<left>")
