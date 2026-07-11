return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    -- 'OXY2DEV/markview.nvim',
  },
  branch = "main",
  build = ':TSUpdate',

  config = function()
    require('nvim-treesitter-textobjects').setup {
      -- Keep module options here; keymaps are defined explicitly below.
      select = {
        enable = true,
        lookahead = true,
      },

      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    }

    local incsel = require('vim.treesitter._select')
    local select = require('nvim-treesitter-textobjects.select')
    local move = require('nvim-treesitter-textobjects.move')
    local swap = require('nvim-treesitter-textobjects.swap')

    -- Neovim 0.12 exposes incremental selection in core, so map the legacy
    -- keys directly to the new helper module.
    vim.keymap.set('n', '<c-space>', function()
      incsel.select_child(vim.v.count1)
    end)
    vim.keymap.set('x', '<c-space>', function()
      incsel.select_parent(vim.v.count1)
    end)
    vim.keymap.set({ 'n', 'x' }, '<c-s>', function()
      incsel.select_grow_next(vim.v.count1)
    end)
    vim.keymap.set({ 'n', 'x' }, '<M-space>', function()
      incsel.select_child(vim.v.count1)
    end)

    for _, mode in ipairs({ 'x', 'o' }) do
      vim.keymap.set(mode, 'aa', function()
        select.select_textobject('@parameter.outer', 'textobjects', mode)
      end)
      vim.keymap.set(mode, 'ia', function()
        select.select_textobject('@parameter.inner', 'textobjects', mode)
      end)
      vim.keymap.set(mode, 'af', function()
        select.select_textobject('@function.outer', 'textobjects', mode)
      end)
      vim.keymap.set(mode, 'if', function()
        select.select_textobject('@function.inner', 'textobjects', mode)
      end)
      vim.keymap.set(mode, 'ac', function()
        select.select_textobject('@class.outer', 'textobjects', mode)
      end)
      vim.keymap.set(mode, 'ic', function()
        select.select_textobject('@class.inner', 'textobjects', mode)
      end)
    end

    for _, mode in ipairs({ 'n', 'x', 'o' }) do
      vim.keymap.set(mode, ']m', function()
        move.goto_next_start('@function.outer', 'textobjects')
      end)
      vim.keymap.set(mode, ']]', function()
        move.goto_next_start('@class.outer', 'textobjects')
      end)
      vim.keymap.set(mode, ']M', function()
        move.goto_next_end('@function.outer', 'textobjects')
      end)
      vim.keymap.set(mode, '][', function()
        move.goto_next_end('@class.outer', 'textobjects')
      end)
      vim.keymap.set(mode, '[m', function()
        move.goto_previous_start('@function.outer', 'textobjects')
      end)
      vim.keymap.set(mode, '[[', function()
        move.goto_previous_start('@class.outer', 'textobjects')
      end)
      vim.keymap.set(mode, '[M', function()
        move.goto_previous_end('@function.outer', 'textobjects')
      end)
      vim.keymap.set(mode, '[]', function()
        move.goto_previous_end('@class.outer', 'textobjects')
      end)
    end

    vim.keymap.set('n', '<leader>a', function()
      swap.swap_next('@parameter.inner')
    end)
    vim.keymap.set('n', '<leader>A', function()
      swap.swap_previous('@parameter.inner')
    end)
  end,

  -- https://github.com/OXY2DEV/markview.nvim/issues/365#issuecomment-3020803413
  priority = 50,
}
