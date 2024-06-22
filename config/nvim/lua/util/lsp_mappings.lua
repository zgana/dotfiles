on_attach = function(_, bufnr)
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
  nmap('<leader>cc', vim.lsp.buf.rename, '[C]hange name (rename)')
  nmap('<leader>cr', vim.lsp.buf.references, '[R]eferences')

  nmap('<leader>==', function() vim.lsp.buf.format { async = true } end, 'Format with LSP')
  nmap('<leader>=.', function() require('conform').format { async = true } end, 'Format with Formatter')
  -- TODO: <leader>=i to fix imports, <leader>=a to fix all, etc

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>csd', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>csl', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[L]SP Workspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>lfa', vim.lsp.buf.add_workspace_folder, '[L]SP Workspace [F]older [A]dd')
  nmap('<leader>lfr', vim.lsp.buf.remove_workspace_folder, '[L]SP Workspace [F]older [R]emove')
  nmap('<leader>lfl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[L]SP Workspace [F]older [L]ist')

  nmap('<leader>li', ":LspInfo<cr>", '[L]SP [I]nfo')
  nmap('<leader>ll', ":LspLog<cr>", '[L]SP [L]og')
  nmap('<leader>lr', ":LspRestart<cr>", '[L]SP [R]estart')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  -- stop this from being overridden (?)
  vim.o.formatoptions = 'tcqnjr'
end

return {
  on_attach = on_attach,
}
