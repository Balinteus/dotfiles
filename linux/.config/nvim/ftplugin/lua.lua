vim.lsp.start({
  name = "Lua LSP",
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  single_file_support = true,
  root_dir = vim.fs.root(0, { ".git"}),
})
