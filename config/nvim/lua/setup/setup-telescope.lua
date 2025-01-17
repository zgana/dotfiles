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

-- See `:help telescope.builtin`
local tb = require('telescope.builtin')

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
  local git_root = vim.fn.systemlist(
    "git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel"
  )[1]
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
    tb.live_grep({
      search_dirs = { git_root },
    })
  end
end

local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc })
end


-- finding files
nmap('<leader><space>', tb.oldfiles, '[ ] Find recently opened files')
nmap('<leader><tab>', tb.oldfiles, '[\\t] Find existing buffers')
nmap('<leader>/f', tb.find_files, 'Find [f]iles in cwd')
nmap('<leader>/g', tb.git_files, 'Find files in [g]it repo')

-- searching for nearby file contents
nmap('<leader>//', tb.current_buffer_fuzzy_find, '[/] Search current buffer')
nmap('<leader>/.', tb.live_grep, '[.] Search current dir')
nmap('<leader>/r', live_grep_git_root, '[/] Search [r]epository')
nmap('<leader>/w', tb.grep_string, 'Search instances of [w]ord')

-- searching other stuff
nmap('<leader>/h', tb.help_tags, 'Search [h]elp')
nmap('<leader>/d', tb.diagnostics, 'Search [d]iagnostics')
nmap('<leader>/?', tb.current_buffer_fuzzy_find, '[?] Resume previous search')

-- vim: ts=2 sts=2 sw=2 et
