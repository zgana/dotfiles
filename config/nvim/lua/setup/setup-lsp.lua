-- [[ Configure LSP ]]

-- Setup neovim lua configuration
require('neodev').setup()

-- Support toggling diagnostics
require('toggle_lsp_diagnostics').init(vim.diagnostic.config())


--  This function gets run when an LSP connects to a particular buffer.
local on_attach = require("util.lsp_mappings").on_attach

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]SP Workspace', _ = 'which_key_ignore' },
}

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  clangd = {},
  -- gopls = {},

  -- We anxiously await the resolution to #22
  -- https://github.com/mtshiba/pylyzer/issues/22
  -- pylyzer = {},

  pyright = {
    python = {
      analysis = {
        typeCheckingMode = "basic"
        -- consider:
        -- typeCheckingMode = "off"
      }
    }
  },

  rust_analyzer = {
    enable = false,
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        buildScripts = {
          enable = true,
        }
      }
    }
  },

  jdtls = {},

  -- tsserver = {},
  html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
local mason_nvim_dap = require 'mason-nvim-dap'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_nvim_dap.setup({
  ensure_installed = {
    "codelldb",
  }
})

mason_lspconfig.setup_handlers {
  function(server_name)
    -- vim.print("Setting up LSP " .. server_name .. " with settings:")
    local settings = servers[server_name]
    -- vim.print(settings)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = settings,
      filetypes = (settings or {}).filetypes,
    }
  end,
  ["rust_analyzer"] = function () end,
}


-- vim: ts=2 sts=2 sw=2 et
