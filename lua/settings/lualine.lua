local colors = {
  rosewater = '#f5e0dc',
  flamingo  = '#f2cdcd',
  pink      = '#f5c2e7',
  mauve     = '#cba6f7',
  red       = '#f38ba8',
  maroon    = '#eba0ac',
  peach     = '#fab387',
  yellow    = '#f9e2af',
  green     = '#a6e3a1',
  teal      = '#94e2d5',
  sky       = '#89dceb',
  sapphire  = '#74c7ec',
  blue      = '#89b4fa',
  lavender  = '#b4befe',
  text      = '#cdd6f4',
  subtext1  = '#bac2de',
  subtext0  = '#a6adc8',
  overlay2  = '#9399b2',
  overlay1  = '#7f849c',
  overlay0  = '#6c7086',
  surface2  = '#585b70',
  surface1  = '#45475a',
  surface0  = '#313244',
  base      = '#1e1e2e',
  mantle    = '#181825',
  crust     = '#11111b',
}

local mocha_theme = {
  normal = {
    a = { fg = colors.crust, bg = colors.pink, gui = 'bold' },
    b = { fg = colors.text, bg = colors.surface0 },
    c = { fg = colors.text, bg = colors.mantle },
  },

  insert = { a = { fg = colors.crust, bg = colors.teal, gui = 'bold' } },
  visual = { a = { fg = colors.crust, bg = colors.mauve, gui = 'bold' } },
  replace = { a = { fg = colors.crust, bg = colors.red, gui = 'bold' } },
  command = { a = { fg = colors.crust, bg = colors.yellow, gui = 'bold' } },
  terminal = { a = { fg = colors.crust, bg = colors.sapphire, gui = 'bold' } },

  inactive = {
    a = { fg = colors.text, bg = colors.crust, gui = 'bold' },
    b = { fg = colors.text, bg = colors.crust },
    c = { fg = colors.text },
  },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = mocha_theme,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
