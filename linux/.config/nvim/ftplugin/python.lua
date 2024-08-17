local root_dir_files = {
  "__init__.py",
  "main.py",
  "setup.py",
  "requirements.txt",
  "pyproject.toml",
  ".git"
}

vim.lsp.start({
  name = "python",
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = vim.fs.root(0, root_dir_files)
})
