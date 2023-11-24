vim.o.autoread = true
vim.o.autochdir = true
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
vim.o.number = true
vim.o.ruler = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.wildmenu = true

vim.o.backspace = 'eol,indent,start'
vim.o.browsedir = 'current'
vim.o.bufhidden = 'hide'
vim.o.cinoptions = '(0,g0,t0,Ws,*200,:0,)200'
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.grepprg = 'grep -nH $*'
vim.o.nrformats = ''
vim.o.shiftwidth = 4
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.softtabstop = 4
vim.o.tabstop = 8
vim.o.textwidth = 100
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


-- vim: ts=2 sts=2 sw=2 et fdm=marker
