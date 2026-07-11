return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_fold_enabled = 1

    if vim.fn.has('macunix') == 1 then
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1
      -- In Skim, set Sync -> Custom to:
      -- nvim --headless -c "VimtexInverseSearch %line '%file'"
    else
      vim.g.vimtex_view_method = 'generic'
      vim.g.vimtex_view_general_viewer = 'okular'
      vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'
      -- In Okular, set the editor command to:
      -- nvim --headless -c "VimtexInverseSearch %l '%f'"
    end
  end,
}
