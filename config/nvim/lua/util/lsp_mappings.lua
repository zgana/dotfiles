local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a func that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local vmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('v', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code [A]ction')
  vmap('<leader>ca', vim.lsp.buf.code_action, 'Code [A]ction')
  nmap('<leader>cr', vim.lsp.buf.rename, '[R]ename')

  nmap('<leader>=', function() vim.lsp.buf.format { async = true } end, 'Format with LSP')
  vmap('<leader>=', function() vim.lsp.buf.format { async = true } end, 'Format with LSP')
  nmap('<leader>+', function() require('conform').format { async = true } end, 'Format with Formatter')
  -- TODO: <leader>=i to fix imports, <leader>=a to fix all, etc

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>csd', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>csl', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[L]SP Workspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap("gD", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", "[G]oto [D]efinition in new tab")

  nmap('<leader>lfa', vim.lsp.buf.add_workspace_folder, '[L]SP Workspace [F]older [A]dd')
  nmap('<leader>lfr', vim.lsp.buf.remove_workspace_folder, '[L]SP Workspace [F]older [R]emove')
  nmap('<leader>lfl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[L]SP Workspace [F]older [L]ist')

  nmap('<leader>li', ":LspInfo<cr>", '[L]SP [I]nfo')
  nmap('<leader>ll', ":LspLog<cr>", '[L]SP [L]og')
  nmap('<leader>lr', ":LspRestart<cr>", '[L]SP [R]estart')

  -- stop this from being overridden (?)
  vim.o.formatoptions = 'tcqnjr'

-- document key chains
  require('which-key').add {
    { "<leader>c", group = "[C]ode" },
    { "<leader>c_", hidden = true },
    { "<leader>g", group = "[G]it" },
    { "<leader>g_", hidden = true },
    { "<leader>h", group = "More git" },
    { "<leader>h_", hidden = true },
    { "<leader>l", group = "[L]SP Workspace" },
    { "<leader>l_", hidden = true },
    { "<leader>s", group = "[S]earch" },
    { "<leader>s_", hidden = true },
  }

end

return {
  on_attach = on_attach,
}
