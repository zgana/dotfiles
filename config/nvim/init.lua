-- This config is based on kickstart-modular.nvim
-- which is a fork of the single-file kickstart.nvim
-- - https://github.com/dam9000/kickstart-modular.nvim
-- - https://github.com/nvim-lua/kickstart.nvim

-- Set <space> as the leader key before any plugins are loaded
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable netrw at very start as well
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Install `lazy.nvim` plugin manager ]]
require('lazy-bootstrap')

-- [[ Configure plugins ]]
require('lazy-plugins')

-- [[ Setting options ]]
require('opts')

-- [[ Basic Keymaps ]]
require('keymaps')

-- [[ Apply plugin configurations ]]
require('setup')

-- vim: ts=2 sts=2 sw=2 et
