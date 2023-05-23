-- set backword kill word
vim.keymap.set(
  'i',
  '<M-BS>',
  '<C-w>',
  { noremap = true, silent = true }
)


-- kill buffer
vim.keymap.set({'n', 'v'}, '<leader>kb', ':bd<CR>', { silent = true })

-- save file
vim.keymap.set({'i', 'n', 'v'}, '<C-s>', ':w<CR>')

-- move line
vim.keymap.set('n', '<M-j>', 'ddp')
vim.keymap.set('n', '<M-k>', 'ddkP')

-- break line
vim.keymap.set('n', '<leader><Enter>', 'a<Enter><Esc>')

-- add blank line
vim.keymap.set('n', '<M-o>', 'o<Esc>k')
vim.keymap.set('n', '<M-O>', 'O<Esc>j')
vim.keymap.set('i', '<M-o>', '<End><Enter><Up>')
vim.keymap.set('i', '<M-O>', '<Home><Enter>')

-- move with HJKL in insert mode
vim.keymap.set('i', '<M-h>', '<Left>')
vim.keymap.set('i', '<M-j>', '<Down>')
vim.keymap.set('i', '<M-k>', '<Up>')
vim.keymap.set('i', '<M-l>', '<Right>')

-- surround with single quote
vim.keymap.set('v', '\'', 'c\'<C-c>pa\'')

-- do nothing when pressing space for not confict with leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

