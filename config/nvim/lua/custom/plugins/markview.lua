return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  -- https://github.com/OXY2DEV/markview.nvim/issues/365#issuecomment-3020803413
  priority = 49,

  -- For blink.cmp's completion
  -- source
  -- dependencies = {
  --     "saghen/blink.cmp"
  -- },


  config = function()
    vim.keymap.set("n", "<leader>uM", "<cmd>Markview toggle<cr>", { desc = "Toggle [M]arkview" })
  end
};
