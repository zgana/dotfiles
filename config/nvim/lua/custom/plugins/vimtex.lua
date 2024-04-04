return {
  'lervag/vimtex',
  lazy=false,
  init = function()
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_fold_enabled = 1
  end,
}
