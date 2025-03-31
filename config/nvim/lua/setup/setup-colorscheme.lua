local chosen = 'kanagawa'

-- apply kanagawa configuration
require("kanagawa").setup({
  commentStyle = { italic = false },
  keywordStyle = { italic = false },
  overrides = function()
    return {
      ["@variable.builtin"] = { italic = false },
    }
  end
})


-- -- apply everforest configuration
-- vim.g.everforest_background = 'hard'
-- vim.g.everforest_disable_italic_comment = true

-- finally apply the colorscheme
vim.cmd.colorscheme(chosen)
