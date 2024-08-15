-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local telescope = require('telescope')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        -- ['<C-u>'] = false,
        -- ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
  },
  extensions = {
    emoji = {
      action = function(emoji)
        -- argument emoji is a table.
        -- {name="", value="", cagegory="", description=""}
        vim.fn.setreg("", emoji.value)
      --   -- insert emoji when picked
      --   -- vim.api.nvim_put({ emoji.value }, 'c', false, true)
      end,
    }
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')

telescope.load_extension("emoji")
telescope.load_extension('lsp_handlers')
telescope.load_extension('ui-select')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = {git_root},
    })
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
local tb = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', tb.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><tab>', tb.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', tb.current_buffer_fuzzy_find, { desc = "[/] Find in current buffer" })

-- [Example of more complex config]
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })


vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- vim.keymap.set('n', '<leader>ue', ":Telescope emoji<cr>", { desc = "Search for [e]moji" })

-- vim: ts=2 sts=2 sw=2 et
