vim.lsp.start({
  name = "bash",
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh" },
  single_file_support = true,
  root_dir = vim.fs.root(0, { ".git" }),
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)"
    }
  }
})
