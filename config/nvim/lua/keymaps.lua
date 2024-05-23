-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- system clipboard
vim.keymap.set('i', '<M-v>', '<c-o>:set paste<cr><c-r>+<c-o>:set nopaste<cr>', { silent = true })
vim.keymap.set('s', '<M-v>', 'c<c-o>"+P', { silent = true })
vim.keymap.set('c', '<M-v>', '<c-r>+ <backspace>', { silent = true })
vim.keymap.set('v', '<M-c>', '"+y', { silent = true })
if vim.fn.has('macunix') ~= 0 then
  vim.keymap.set('i', '<D-v>', '<c-o>:set paste<cr><c-r>+<c-o>:set nopaste<cr>', { silent = true })
  vim.keymap.set('s', '<D-v>', 'c<c-o>"+P', { silent = true })
  vim.keymap.set('c', '<D-v>', '<c-r>+ <backspace>', { silent = true })
  vim.keymap.set('v', '<D-c>', '"+y', { silent = true })
end

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[0', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']0', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- commandline backscroll
vim.keymap.set("c", "<c-p>", "<up>", { desc = "Go to previous similar command" })
vim.keymap.set("c", "<c-n>", "<down>", { desc = "Go to next similar command" })

-- luasnip
local ls = require('luasnip')
vim.keymap.set({'i'}, '<c-k>', function() ls.expand() end, { silent = true })
vim.keymap.set({'i', 's'}, '<c-l>', function() ls.jump( 1) end, { silent = true })
vim.keymap.set({'i', 's'}, '<c-j>', function() ls.jump(-1) end, { silent = true })
vim.keymap.set({'i', 's'}, '<c-e>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- dap
local dapui = require("dapui")

local wk = require('which-key')

local wk_mappings = {
  -- windows
  w = {
    v = { "<c-w><c-v>", "Create vertical split to right" },
    V = { "<c-w><c-v><c-w>l", "Create and enter vertical split to right" },
    s = { "<c-w><c-s>", "Create split below" },
    S = { "<c-w><c-s><c-w>j", "Create and enter split below" },

    -- w = { "<c-w><c-w>", "Enter next window" },
    w = { ":w<cr>", "Write buffer in current window" },
    h = { "<c-w>h", "Enter window to left" },
    l = { "<c-w>l", "Enter window to right" },
    k = { "<c-w>k", "Enter window above" },
    j = { "<c-w>j", "Enter window below" },

    o = { "<c-w>o", "Keep only the current active window" },
    q = { "<c-w>q", "Quit the current active window" },
    x = { ":copen<cr>", "Open new buffer in new window" },

    ["1"] = { "1<c-w><c-w>", "Enter window #1" },
    ["2"] = { "2<c-w><c-w>", "Enter window #2" },
    ["3"] = { "3<c-w><c-w>", "Enter window #3" },
    ["4"] = { "4<c-w><c-w>", "Enter window #4" },
    ["5"] = { "5<c-w><c-w>", "Enter window #5" },
    ["6"] = { "6<c-w><c-w>", "Enter window #6" },
    ["7"] = { "7<c-w><c-w>", "Enter window #7" },
    ["8"] = { "8<c-w><c-w>", "Enter window #8" },
    ["9"] = { "9<c-w><c-w>", "Enter window #9" },
  },

  -- windows (direct switch)
  ["1"] = { "1<c-w><c-w>", "Enter window #1" },
  ["2"] = { "2<c-w><c-w>", "Enter window #2" },
  ["3"] = { "3<c-w><c-w>", "Enter window #3" },
  ["4"] = { "4<c-w><c-w>", "Enter window #4" },
  ["5"] = { "5<c-w><c-w>", "Enter window #5" },
  ["6"] = { "6<c-w><c-w>", "Enter window #6" },
  ["7"] = { "7<c-w><c-w>", "Enter window #7" },
  ["8"] = { "8<c-w><c-w>", "Enter window #8" },
  ["9"] = { "9<c-w><c-w>", "Enter window #9" },


  -- tab pages
  t = {
    [","] = { ":tabmove -1<cr>", "Rearrange current tab to the left" },
    ["."] = { ":tabmove +1<cr>", "Rearrange current tab to the right" },
    ["t"] = { ":tabedit<cr>", "Open new [t]ab" },
    ["q"] = { ":tabclose<cr>", "[Q]uit current tab" },
    ["1"] = { "1gt", "Enter tab #1" },
    ["2"] = { "2gt", "Enter tab #2" },
    ["3"] = { "3gt", "Enter tab #3" },
    ["4"] = { "4gt", "Enter tab #4" },
    ["5"] = { "5gt", "Enter tab #5" },
    ["6"] = { "6gt", "Enter tab #6" },
    ["7"] = { "7gt", "Enter tab #7" },
    ["8"] = { "8gt", "Enter tab #8" },
    ["9"] = { "9gt", "Enter tab #9" },
  },

  -- files
  f = {
    -- name = "[F]iles",
    -- _ = 'which_key_ignore',
    o = {
      f = { ":edit ~/.config/nvim/init.lua<cr>", "Edit root config" },
      k = { ":edit ~/.config/nvim/lua/keymaps.lua<cr>", "Edit keymaps" },
      n = { ":edit ~/.config/nvim/<cr>", "Edit root config directory" },
      s = { ":edit ~/.dotfiles/<cr>", "Edit dotfiles directory" },

      -- temporary
      F = {
        ":tabedit ~/.dotfiles/config/nvim-lua-1/init.lua<cr>",
        "Edit previous root config in new tab",
      },
    },
    s = {
      k = {
        ":source ~/.config/nvim/lua/keymaps.lua<cr>"
        .. ":lua print('Keymaps reloaded.')<cr>",
        "Reload keymaps",
        },
      ["."] = {
        ":source %<cr>"
        .. ":lua print('Sourced.')<cr>",
        "Source current file",
      }
    }
  },

  -- debug
  b = {
    b = { "<cmd> DapToggleBreakpoint <cr>", "Toggle [B]reakpoint" },
    i = { "<cmd> DapStepInto <cr>", "[S]tep [I]nto" },
    s = { "<cmd> DapStepOver <cr>", "[S]tep Over" },
    o = { "<cmd> DapStepOut <cr>", "[S]tep [O]ut" },
    t = { "<cmd> DapTerminate <cr>", "[T]erminate" },
    u = { dapui.toggle, "[U]I [T]oggle" },
  },

  -- code stuff
  c = {
    L = { vim.lsp.codelens.refresh, "Code[L]ens Refresh" },
    l = { vim.lsp.codelens.run, "Code[L]ens Run" },
  },

  -- more search stuff
  s = {
    c = {
      r = {  "<cmd> Telescope lsp_references <cr>", "[C]ode [R]eferences" },
    },
  },

  -- UI
  u = {
    a = { ":AerialToggle<cr>", "Toggle [A]erial" },
    c = { ":Telescope colorscheme sorting_strategy=ascending<cr>", "Colorschemes" },
    d = {
      ":ToggleDiag<cr><c-l>"
      .. ":lua print('LSP diagnostics toggled.')<cr>"
      ,
      "Toggle LSP diagnostics"
    },
    e = { ":Telescope emoji<cr>", "Search for [e]moji" },
    n = { ":set number!<cr>", "Toggle line [n]umbers" },
    i = { ":IBLToggle<cr>", "Toggle indentation guides" },
    s = { ":set spell!<cr>", "Toggle spellcheck" },
    t = { ":NvimTreeToggle<cr>", "Toggle [T]ree" },
    w = { ":set wrap!<cr>", "Toggle [w]rap" },
    W = { function()
      local wrap = vim.o.wrap
      vim.o.wrap = not wrap
      vim.o.linebreak = not wrap
    end, "Toggle [w]rap (text)" }
  },

  -- section documentation

}

local wk_opts = {
  prefix = "<leader>",
  silent = true,
}

wk.register(wk_mappings, wk_opts)


local wk_docs = {
  ["<leader>b"] = { name = "De[B]ug", _ = "which_key_ignore"},
  ["<leader>f"] = { name = "Config [F]iles", _ = "which_key_ignore"},
  ["<leader>fo"] = { name = "[O]pen...", _ = "which_key_ignore"},
  ["<leader>fs"] = { name = "[S]ource...", _ = "which_key_ignore"},
  ["<leader>u"] = { name = "[U]ser Interface", _ = "which_key_ignore"},
  ["<leader>t"] = { name = "[T]abs", _ = "which_key_ignore"},
  ["<leader>w"] = { name = "[W]indows", _ = "which_key_ignore"},
}
wk.register(wk_docs, { silent = true })

-- -- [[ Highlight on yank ]]
-- -- See `:help vim.highlight.on_yank()`
-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   callback = function()
--     vim.highlight.on_yank()
--   end,
--   group = highlight_group,
--   pattern = '*',
-- })

-- vim: ts=2 sts=2 sw=2 et
