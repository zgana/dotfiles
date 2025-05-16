-- For `plugins/markview.lua` users.
return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  -- For blink.cmp's completion
  -- source
  -- dependencies = {
  --     "saghen/blink.cmp"
  -- },

  config = function()
    vim.keymap.set("n", "<leader>mt", "<cmd>Markview toggle<cr>", { desc = "[M]arkview [t]oggle" })
  end
};
