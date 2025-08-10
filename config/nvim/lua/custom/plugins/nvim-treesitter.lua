return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'OXY2DEV/markview.nvim',
  },
  build = ':TSUpdate',

  -- https://github.com/OXY2DEV/markview.nvim/issues/365#issuecomment-3020803413
  priority = 50,
}
