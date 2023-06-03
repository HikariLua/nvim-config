require('oil').setup {
  columns = {
    'icon',
  },

  keymaps = {
    ['<M-l>'] = 'actions.select',
    ["<CR>"] = "actions.select",
    ["g?"] = "actions.show_help",
    ["<M-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ['<M-h>'] = 'actions.parent',
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["g."] = "actions.toggle_hidden",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = false,
}

vim.keymap.set('n', '-', require('oil').open, { desc = 'Open parent directory' })
