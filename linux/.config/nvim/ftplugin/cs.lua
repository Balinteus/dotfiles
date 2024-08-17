vim.lsp.start({
  name = "C# LSP",
  cmd = { "csharp-ls" },
  filetypes = { "cs" },
  root_dir = vim.fs.root(0, { "*.sln", "*.csproj" }),
})
