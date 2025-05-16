-- vim.keymap.set("n", "<leader>q", function()
--   require("quicker").toggle()
-- end, {
--   desc = "Toggle quickfix",
-- })
-- vim.keymap.set("n", "<leader>l", function()
--   require("quicker").toggle({ loclist = true })
-- end, {
--   desc = "Toggle loclist",
-- })
--
-- require("quicker").setup({
--   keys = {
--     {
--       ">",
--       function()
--         require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
--       end,
--       desc = "Expand quickfix context",
--     },
--     {
--       "<",
--       function()
--         require("quicker").collapse()
--       end,
--       desc = "Collapse quickfix context",
--     },
--   },
-- })

return {
  'stevearc/quicker.nvim',
  event = "FileType qf",
  lazy = false,
  opts = {
    highlight = {
      -- Use treesitter highlighting
      treesitter = true,
      -- Use LSP semantic token highlighting
      lsp = true,
      -- Load the referenced buffers to apply more accurate highlights (may be slow)
      load_buffers = false,
    },

    edit = {
      -- Enable editing the quickfix like a normal buffer
      enabled = true,
      -- Set to true to write buffers after applying edits.
      -- Set to "unmodified" to only write unmodified buffers.
      autosave = "unmodified",
    },

  },

  config = function()
    vim.keymap.set("n", "<leader>qq", function()
      require("quicker").toggle()
    end, {
      desc = "Toggle quickfix",
    })

    vim.keymap.set("n", "<leader>ql", function()
      require("quicker").toggle({ loclist = true })
    end, {
      desc = "Toggle loclist",
    })

    local keys = {
      {
        ">",
        function()
          require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = "Expand quickfix context",
      },
      {
        "<",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context",
      },
    }
    require("quicker").setup({keys = keys})
  end
}
