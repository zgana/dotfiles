require("aerial").setup({
  layout = {
    max_width = { 40, 0.3 },
  },
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    -- vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    -- vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
