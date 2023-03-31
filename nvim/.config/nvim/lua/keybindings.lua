local mapopts = { silent = true, noremap = true }

-- Builtins
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', mapopts)
vim.keymap.set('n', '<leader>j', '<cmd>join<cr>', mapopts)
vim.keymap.set('n', 'J', '5j', mapopts)
vim.keymap.set('n', 'K', '5k', mapopts)
vim.keymap.set('i', 'jj', '<esc>', mapopts)
vim.keymap.set('n', '<c-j>', '<c-w>j', mapopts)
vim.keymap.set('n', '<c-k>', '<c-w>k', mapopts)
vim.keymap.set('n', '<c-h>', '<c-w>h', mapopts)
vim.keymap.set('n', '<c-l>', '<c-w>l', mapopts)

-- Helpers
vim.keymap.set('n', '<leader>s', [[:%s/\s\+$//e<cr>]])

-- Plugin bindings
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', mapopts)
