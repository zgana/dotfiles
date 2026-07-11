-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
local ensure_installed = {
  -- If a parser is missing entirely, reinstall from the nvim-treesitter repo:
  -- `nvim -l scripts/install-parsers.lua python rust` (run in the plugin checkout).
  'c', 'cpp', 'go', 'lua',
  'java', 'scala',
  'html', 'css',
  'latex', 'markdown',
  'python',
  'rust',
  'jsx', 'tsx', 'javascript', 'typescript',
  'vimdoc', 'vim', 'bash'
}

local function install_missing_parsers()
  local ok, treesitter = pcall(require, 'nvim-treesitter')
  if not ok then
    return
  end

  local installed = {}
  for _, lang in ipairs(treesitter.get_installed()) do
    installed[lang] = true
  end

  local missing = {}
  for _, lang in ipairs(ensure_installed) do
    if not installed[lang] then
      missing[#missing + 1] = lang
    end
  end

  if #missing == 0 then
    return
  end

  -- Temporary stopgap until a clearer parser manager wins out upstream.
  local install_ok, err = pcall(function()
    treesitter.install(missing):wait(300000)
  end)

  if not install_ok then
    vim.schedule(function()
      vim.notify(('Treesitter parser install failed: %s'):format(err), vim.log.levels.WARN)
    end)
  end
end

install_missing_parsers()

require('nvim-treesitter.config').setup {
  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  ensure_installed = ensure_installed,

  -- fold = {
  --   enable = true,
  --   disable = { "python" },
  -- },

  highlight = {
    enable = true
  },

  indent = {
    enable = true,
    disable = { "python", "rust", "markdown" }
  },
}

-- vim: ts=2 sts=2 sw=2 et
