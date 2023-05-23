return {
  -- don't change this onedark theme, if you do neovim breaks in a
  -- inconsistent way and I don't know why
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  'EdenEast/nightfox.nvim',
  'folke/tokyonight.nvim',
  { 'rose-pine/neovim', name = 'rose-pine' },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  'Mofiqul/dracula.nvim',
  'matgd/godotcolor-vim',
}

