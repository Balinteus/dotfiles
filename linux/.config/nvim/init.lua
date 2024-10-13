-- Essential remaps
vim.g.mapleader = ' '
vim.keymap.set({'i', 'c'}, "jk", "<ESC>")
vim.keymap.set('n', "<leader>é", "<CMD>Lex<CR>")
vim.keymap.set('n', "<ESC>", "<CMD>nohlsearch<CR>")
vim.keymap.set('n', "<C-TAB>", "<CMD>b#<CR>")

-- Basic Sets
vim.o.nu = true
vim.o.rnu = true
vim.o.list = true
vim.o.ruler = true
vim.o.scrolloff = 8
vim.o.laststatus = 2
vim.o.showtabline = 1
vim.o.splitright = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "80"
vim.g.noerrorbells = true

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.shortmess:remove { 'S' }

vim.g.wrap = false
vim.g.linebreak = true

vim.o.autochdir = true
vim.o.autoread = true
vim.o.undofile = true
vim.g.noswapfile = true

vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- NETRW Settings
vim.g.netrw_banner = 0

-- Buffer switching binds
for i=1,9 do
  vim.keymap.set(
    'n', string.format("<leader>%d<CR>", i), string.format("%dgt", i)
  )
end

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup(
  "YankHighlight", { clear = true }
)
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = '*',
})

-- Load plugins & helpers (if not in a minimal setup environment)
if os.getenv("NVIM_SETUP_TYPE") ~= "minimal" then
  require("plugins")
  require("lsp")
  require("vanilla.autoclosing")
  require("vanilla.snippets")
end
