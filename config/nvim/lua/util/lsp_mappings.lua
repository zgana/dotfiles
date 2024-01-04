on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a func that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code [A]ction')
  nmap('<leader>cr', vim.lsp.buf.rename, '[R]ename')

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
  nmap('<leader>la', vim.lsp.buf.add_workspace_folder, '[L]SP Workspace [A]dd Folder')
  nmap('<leader>lr', vim.lsp.buf.remove_workspace_folder, '[L]SP Workspace [R]emove Folder')
  nmap('<leader>ll', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[L]SP Workspace [L]ist Folders')

  nmap('<leader>lI', ":LspInfo<cr>", '[L]SP [I]nfo')
  nmap('<leader>lL', ":LspLog<cr>", '[L]SP [L]og')
  nmap('<leader>lR', ":LspRestart<cr>", '[L]SP [R]estart')

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
