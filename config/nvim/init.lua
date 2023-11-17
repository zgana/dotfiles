vim.o.compatible = false

-- Lazy: Package Manager {{{

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- set `mapleader` before lazy so mappings are correct
vim.g.mapleader = " "

-- choose plugins
require("lazy").setup({
  -- space maps
  "folke/which-key.nvim",

  -- neovim lua stuff (?)
  { 'folke/neoconf.nvim', cmd = "Neoconf" },
  'folke/neodev.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  'nvim-telescope/telescope.nvim',

  -- more editing support
  'neovim/nvim-lspconfig',
  'j-hui/fidget.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-cmdline',
  'windwp/nvim-autopairs',
  'tpope/vim-commentary',
  'tpope/vim-surround',
  'tpope/vim-repeat',

  -- Rust
  'simrat39/rust-tools.nvim',

  -- Python
  'tmhedberg/SimpylFold',

  -- theme
  -- 'vim-airline/vim-airline',
  -- 'vim-airline/vim-airline-themes',
  'nvim-lualine/lualine.nvim',
  'nvim-tree/nvim-web-devicons',

  -- fold
  "Konfekt/FastFold",

  -- color
  'sainnhe/everforest',

})

-- }}}


-- Core builtins {{{

vim.o.autoread = true
vim.o.cursorline = true
vim.o.errorbells = false
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.joinspaces = true
vim.o.magic = true
vim.o.modeline = true
vim.o.ruler = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.wildmenu = true

vim.o.backspace = 'eol,indent,start'
vim.o.browsedir = 'current'
vim.o.browsedir = 'current'
vim.o.bufhidden = 'hide'
vim.o.bufhidden = 'hide'
vim.o.cinoptions = '(0,g0,t0,Ws,*200,:0,)200'
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.formatoptions = vim.o.formatoptions .. 'tcqnjr'
vim.o.grepprg = 'grep -nH $*'
vim.o.nrformats = ''
vim.o.shiftwidth = 4
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.softtabstop = 4
vim.o.tabstop = 8
vim.o.textwidth = 88
vim.o.undodir = vim.fn.expand('$HOME/.cache/nvim/undo')
vim.o.undolevels = 1000
vim.o.undoreload = 10000
vim.o.virtualedit = 'block'
vim.o.wildignore = '*.o'
vim.o.wildmode = 'list:longest'

vim.fn.system({
  'mkdir',
  '-p',
  vim.fn.expand('$HOME/.cache/nvim/undo')
})
-- }}}


-- LSP and completion {{{

-- Set up nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- local default_capabilities = require('cmp_nvim_lsp').default_capabilities()


-- global {{{

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { buffer = ev.buf }
    vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, bufopts)
  end,
})
-- }}}

-- lua {{{

require('lspconfig')['lua_ls'].setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

-- }}}

-- pyright {{{
local lspconfig = require('lspconfig')
lspconfig['pyright'].setup {
  capabilities = {
    textDocument = {
      publishDiagnostics = {
        tagSupport = {
          valueSet = { 2 },
        },
      },
    },
  },
  settings = {
    python = {
      analysis = {
        -- maybe we can enable this someday
        -- but soooo much science code is questionably type hinted
        typeCheckingMode = "off",
      }
    }
  }
}
-- }}}

-- ruff {{{
local ruff_on_attach = function(client, bufnr)
  client.server_capabilities.hoverProvider = false

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

lspconfig['ruff_lsp'].setup {
  -- capabilities = capabilities
  on_attach = ruff_on_attach,
}
-- }}}

-- VimL {{{
require 'lspconfig'.vimls.setup {}
-- }}}

-- }}}


-- Editing plugins {{{

vim.g.SimpylFold_fold_import = false
vim.g.SimpylFold_fold_docstring = false

require("fidget").setup()

require("nvim-autopairs").setup({
  map_cr = true
})

-- }}}


-- Theme {{{
vim.g.everforest_background = 'hard'
vim.cmd.colorscheme('everforest')

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
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
    lualine_a = { '%{tabpagewinnr(tabpagenr())}', 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = { '%{tabpagewinnr(tabpagenr())}' },
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

-- }}}


-- Space mappings {{{

local wk = require("which-key")

wk.register({
  -- windows
  w = {
    v = { "<c-w><c-v>", "Create vertical split to right" },
    V = { "<c-w><c-v><c-w>l", "Create and enter vertical split to right" },
    s = { "<c-w><c-s>", "Create split below" },
    S = { "<c-w><c-s><c-w>j", "Create and enter split below" },

    w = { "<c-w><c-w>", "Enter next window" },
    h = { "<c-w>h", "Enter window to left" },
    l = { "<c-w>l", "Enter window to right" },
    k = { "<c-w>k", "Enter window above" },
    j = { "<c-w>j", "Enter window below" },

    o = { "<c-w>o", "Keep only the current active window" },
    q = { "<c-w>q", "Quit the current active window" },
    x = { ":copen<cr>", "Open new buffer in new window" },

    ["1"] = { "1<c-w><c-w>", "Enter window #1" },
    ["2"] = { "2<c-w><c-w>", "Enter window #2" },
    ["3"] = { "3<c-w><c-w>", "Enter window #3" },
    ["4"] = { "4<c-w><c-w>", "Enter window #4" },
    ["5"] = { "5<c-w><c-w>", "Enter window #5" },
    ["6"] = { "6<c-w><c-w>", "Enter window #6" },
    ["7"] = { "7<c-w><c-w>", "Enter window #7" },
    ["8"] = { "8<c-w><c-w>", "Enter window #8" },
    ["9"] = { "9<c-w><c-w>", "Enter window #9" },
  },

  -- tab pages
  t = {
    [","] = { ":tabmove -1<cr>", "Rearrange current tab to the left" },
    ["."] = { ":tabmove +1<cr>", "Rearrange current tab to the right" },
    ["q"] = { ":tabclose", "Quit current tab" },
    ["1"] = { "1gt", "Enter tab #1" },
    ["2"] = { "2gt", "Enter tab #2" },
    ["3"] = { "3gt", "Enter tab #3" },
    ["4"] = { "4gt", "Enter tab #4" },
    ["5"] = { "5gt", "Enter tab #5" },
    ["6"] = { "6gt", "Enter tab #6" },
    ["7"] = { "7gt", "Enter tab #7" },
    ["8"] = { "8gt", "Enter tab #8" },
    ["9"] = { "9gt", "Enter tab #9" },
  },

  --
  f = {
    i = {
      f = { ":tabedit ~/.config/nvim/init.lua<cr>", "Edit root config" },
      n = { ":tabedit ~/.config/nvim/<cr>", "Edit root config directory" },
      s = { ":tabedit ~/.dotfiles/<cr>", "Edit dotfiles directory" },
    }
  },

  -- windows (direct switch)
  ["1"] = { "1<c-w><c-w>", "Enter window #1" },
  ["2"] = { "2<c-w><c-w>", "Enter window #2" },
  ["3"] = { "3<c-w><c-w>", "Enter window #3" },
  ["4"] = { "4<c-w><c-w>", "Enter window #4" },
  ["5"] = { "5<c-w><c-w>", "Enter window #5" },
  ["6"] = { "6<c-w><c-w>", "Enter window #6" },
  ["7"] = { "7<c-w><c-w>", "Enter window #7" },
  ["8"] = { "8<c-w><c-w>", "Enter window #8" },
  ["9"] = { "9<c-w><c-w>", "Enter window #9" },

}, { prefix = "<leader>" })
-- }}}


-- Autocmd {{{

local ag_lua = vim.api.nvim_create_augroup('lua', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.lua',
  group = ag_lua,
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})

-- }}}


-- vim: set fdm=marker:
