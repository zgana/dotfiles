--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
local plugins = {
  -- basics
  'nvim-lua/plenary.nvim',

  -- toggle LSP
  'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',

  -- async IO
  { "nvim-neotest/nvim-nio" },

  -- lua
  'folke/neodev.nvim',

  -- some python
  'tmhedberg/SimpylFold',
  'Vimjas/vim-python-pep8-indent',
  'raimon49/requirements.txt.vim',

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- More tpope
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-rsi',

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- paren/bracket/brace matching
  { 'windwp/nvim-autopairs', opts = {} },

  -- file tree
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',

  -- code symbol tree
  'stevearc/aerial.nvim',

  -- tmux
  'edkolev/tmuxline.vim',

  -- "zen" centered editing
  'shortcuts/no-neck-pain.nvim',

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
opts["performance"] = {
  rtp = {
    -- TODO: can we set this back to true but include specific runtimes?
    -- For example, nvim-qt sets a runtimepath on startup
    reset = false,
  }
}

require('lazy').setup(plugins, opts)


-- vim: ts=2 sts=2 sw=2 et
