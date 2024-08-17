vim.lsp.start({
  name = "C LSP",
  cmd = { "clangd" },
  filetypes = { 'c', "cpp", "objc", "objcpp", "proto" },
  root_dir = vim.fs.root(0, { "Makefile", "main.c", "build.ninja" }),
  single_file_support = true
})
