return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup {
        columns = { "icon" },
        view_options = {
          show_hidden = true,
        },
      }

      vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open current directory" })
    end
  }
}
