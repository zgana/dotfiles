

--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
local plugins = {
  -- basics
  'nvim-lua/plenary.nvim',

  -- toggle LSP
  'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',

  -- more python
  'tmhedberg/SimpylFold',
  'Vimjas/vim-python-pep8-indent',

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- paren/bracket/brace matching
  { 'windwp/nvim-autopairs', opts = {} },

  -- wrap objects/selections
  'tpope/vim-surround',

  -- repeat otherwise non-atomic actions like vim-surround actions
  'tpope/vim-repeat',

  -- file tree
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',

  -- code symbol tree
  'stevearc/aerial.nvim',


  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'custom.plugins' },
}

local opts = {}

local nvim_qt_path = '/usr/share/nvim-qt/runtime'
local nvim_qt_pattern = string.gsub(nvim_qt_path, '-', '.')
if string.find(vim.o.runtimepath, nvim_qt_pattern) then
  opts["performance"] = {
    rtp = {
      paths = {
        nvim_qt_path
      }
    }
  }
end

require('lazy').setup(plugins, opts)


-- vim: ts=2 sts=2 sw=2 et
