local lsp_on_attach = require("util.lsp_mappings").on_attach
local bufnr = vim.api.nvim_get_current_buf()

lsp_on_attach(false, bufnr)

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
