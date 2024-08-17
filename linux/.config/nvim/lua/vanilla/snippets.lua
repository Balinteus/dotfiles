-- Snippets
vim.keymap.set({ 'i', 's' }, '<Tab>', function()
   if vim.snippet.active({ direction = 1 }) then
     vim.snippet.jump(1)
   else
     return '<Tab>'
   end
 end, { expr = true })

vim.keymap.set({ 'n', 'i', 's' }, '<CR>', function()
   if vim.snippet.active() then
     vim.snippet.stop()
   else
     return '<CR>'
   end
 end, { expr = true })

vim.keymap.set('n', '---', function()
   vim.snippet.expand(
      string.format(
         "---\ntitle: ${1:Untitled}\nauthor: ${2:Bálint Gonda}\ndate: ${3:%s}\n---\n\n$4",
         os.date("%Y-%m-%d")
      )
) end)
