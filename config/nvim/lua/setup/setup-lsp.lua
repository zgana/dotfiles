-- [[ Configure LSP ]]

-- Setup neovim lua configuration
require('neodev').setup()

-- Support toggling diagnostics
require('toggle_lsp_diagnostics').init(vim.diagnostic.config())


--  This function gets run when an LSP connects to a particular buffer.
local on_attach = require("util.lsp_mappings").on_attach

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

  -- We anxiously await the resolution to #22
  -- https://github.com/mtshiba/pylyzer/issues/22
  -- pylyzer = {},

  bashls = {
    filetypes = { 'sh', 'bash', 'zsh', },
  },

  basedpyright = {
    basedpyright = {
      analysis = {
        diagnosticMode = 'openFilesOnly',
        typeCheckingMode = 'basic',
        useLibraryCodeForTypes = true,
        -- diagnosticSeverityOverrides = {
        --   autoSearchPaths = true,
        --   enableTypeIgnoreComments = false,
        --   reportGeneralTypeIssues = 'none',
        --   reportArgumentType = 'none',
        --   reportUnknownMemberType = 'none',
        --   reportAssignmentType = 'none',
        -- },
      },
    },
  },


  ruff = {},

  -- ruff_lsp = {
  --   init_options = {
  --     settings = {
  --       -- Any extra CLI arguments for `ruff` go here.
  --       args = {},
  --     }
  --   }
  -- },

  rust_analyzer = {
    enable = false,
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        buildScripts = {
          enable = true,
        }
      },
      files = {
        excludeDirs = {
          "_build",
          ".dart_tool",
          ".flatpak-builder",
          ".git",
          ".gitlab",
          ".gitlab-ci",
          ".gradle",
          ".idea",
          ".next",
          ".project",
          ".scannerwork",
          ".settings",
          ".venv",
          "archetype-resources",
          "bin",
          "hooks",
          "node_modules",
          "po",
          "screenshots",
          "target",
        }
      }
    }
  },

  jdtls = {},

  -- tsserver = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },

  lua_ls = {
  },

}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- https://github.com/hrsh7th/cmp-nvim-lsp/issues/44#issuecomment-2096368152
capabilities.workspace = { didChangeWatchedFiles = { dynamicRegistration = true } }


-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
local mason_nvim_dap = require 'mason-nvim-dap'
local mason_tool_installer = require 'mason-tool-installer'

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

  ["rust_analyzer"] = function() end,

  -- ["lua_ls"] = function(client)
  --   -- see also:
  --   -- https://github.com/neovim/neovim/discussions/24119
  --   Lua = {
  --     runtime = { version = 'LuaJIT' },
  --     workspace = {
  --       checkThirdParty = false,
  --       telemetry = { enable = false },
  --       library = {
  --         vim.env.VIMRUNTIME
  --       }
  --     }
  --   }
  -- end,
}



require("conform").setup({
  formatters_by_ft = {
    bash = { 'beautysh' },
    sh = { 'beautysh' },
    zsh = { 'beautysh' },
  }
})

mason_tool_installer.setup {
  ensure_installed = {
    'beautysh',
  },
}

-- vim: ts=2 sts=2 sw=2 et
