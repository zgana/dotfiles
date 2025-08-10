-- return {
--   -- LSP Configuration & Plugins
--   'neovim/nvim-lspconfig',
--   dependencies = {
--     -- Automatically install LSPs to stdpath for neovim
--     'williamboman/mason.nvim',
--     'williamboman/mason-lspconfig.nvim',
--     'jay-babu/mason-nvim-dap.nvim',
--     "stevearc/conform.nvim",
--     "zapling/mason-conform.nvim",
--     'WhoIsSethDaniel/mason-tool-installer.nvim',
--
--     -- Useful status updates for LSP
--     -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
--     { 'j-hui/fidget.nvim', opts = {} },
--
--     -- Additional lua configuration, makes nvim stuff amazing!
--     'folke/neodev.nvim',
--   },
-- }
--

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    require("util.lsp_mappings").on_attach({bufnr = args.buf})
  end,
})


return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "clangd",
      "bashls",
      "ruff",
      "rust_analyzer",
      "lua_ls",
      "ts_ls",
      "eslint",
      "jsonls",
      "html",
      "cssls",
      "basedpyright",
    },
    automatic_enable = true,
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "folke/neodev.nvim",
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()

    require('toggle_lsp_diagnostics').init(vim.diagnostic.config())

    vim.lsp.config('rust_analyzer', {
      -- Server-specific settings. See `:help lsp-quickstart`
      settings = {
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
      },
    })

    vim.lsp.config('basedpyright', {
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
    })


  end
}
