local chosen = 'kanagawa-dragon'

-- apply any needed configuration
if chosen == 'everforest' then
  vim.g.everforest_background = 'hard'
  vim.g.everforest_disable_italic_comment = true
end

-- finally apply the colorscheme
vim.cmd.colorscheme(chosen)
