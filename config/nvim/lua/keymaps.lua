-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- system clipboard
vim.keymap.set('i', '<M-v>', '<c-o>:set paste<cr><c-r>+<c-o>:set nopaste<cr>', { silent = true })
vim.keymap.set('s', '<M-v>', 'c<c-o>"+P', { silent = true })
vim.keymap.set('c', '<M-v>', '<c-r>+ <backspace>', { silent = true })
vim.keymap.set('v', '<M-c>', '"+y', { silent = true })
vim.keymap.set('v', 'gy', '"+y', { silent = true })
vim.keymap.set('n', 'gy', '"+y', { silent = true })
vim.keymap.set('n', '<leader>yy', '<cmd>%yank +<cr>', { silent = false })


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
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- commandline backscroll
vim.keymap.set("c", "<c-p>", "<up>", { desc = "Go to previous similar command" })
vim.keymap.set("c", "<c-n>", "<down>", { desc = "Go to next similar command" })

-- luasnip
local ls = require('luasnip')
vim.keymap.set({ 'i' }, '<c-k>', function() ls.expand() end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<c-l>', function() ls.jump(1) end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<c-j>', function() ls.jump(-1) end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<c-e>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- dap
local dapui = require("dapui")

local wk = require('which-key')

local wk_mappings = {

  -- direct to numbers
  { "<leader>1",   "1<c-w><c-w>",                                      desc = "Enter window #1" },
  { "<leader>2",   "2<c-w><c-w>",                                      desc = "Enter window #2" },
  { "<leader>3",   "3<c-w><c-w>",                                      desc = "Enter window #3" },
  { "<leader>4",   "4<c-w><c-w>",                                      desc = "Enter window #4" },
  { "<leader>5",   "5<c-w><c-w>",                                      desc = "Enter window #5" },
  { "<leader>6",   "6<c-w><c-w>",                                      desc = "Enter window #6" },
  { "<leader>7",   "7<c-w><c-w>",                                      desc = "Enter window #7" },
  { "<leader>8",   "8<c-w><c-w>",                                      desc = "Enter window #8" },
  { "<leader>9",   "9<c-w><c-w>",                                      desc = "Enter window #9" },

  -- deBugging
  { "<leader>b",   group = "De[B]ug" },
  { "<leader>b_",  hidden = true },
  { "<leader>bb",  "<cmd> DapToggleBreakpoint <cr>",                   desc = "Toggle [B]reakpoint" },
  { "<leader>bi",  "<cmd> DapStepInto <cr>",                           desc = "[S]tep [I]nto" },
  { "<leader>bo",  "<cmd> DapStepOut <cr>",                            desc = "[S]tep [O]ut" },
  { "<leader>bs",  "<cmd> DapStepOver <cr>",                           desc = "[S]tep Over" },
  { "<leader>bt",  "<cmd> DapTerminate <cr>",                          desc = "[T]erminate" },
  { "<leader>bu",  dapui.toggle,                                       desc = "[U]I [T]oggle" },


  { "<leader>c",   group = "[C]ode manipulation" },
  { "<leader>c_",  hidden = true },
  { "<leader>cL",  vim.lsp.codelens.refresh,                           desc = "Code[L]ens Refresh" },
  { "<leader>cl",  vim.lsp.codelens.run,                               desc = "Code[L]ens Run" },

  -- files
  { "<leader>f",   group = "Config [F]iles" },
  { "<leader>f_",  hidden = true },

  -- files: open
  { "<leader>fo",  group = "[O]pen..." },
  { "<leader>fo_", hidden = true },
  { "<leader>fof", ":tabedit ~/.dotfiles/config/nvim/init.lua<cr>",    desc = "Edit root config" },
  { "<leader>fok", ":tabedit ~/.dotfiles/config/nvim/lua/keymaps.lua<cr>", desc = "Edit keymaps config" },
  { "<leader>fos", ":tabedit ~/.dotfiles/<cr>",                        desc = "Edit dotfiles directory" },

  --files: source
  { "<leader>fs",  group = "[S]ource..." },
  { "<leader>fs_", hidden = true },
  {
    "<leader>fs.",
    ":source %<cr>:lua print('Sourced.')<cr>",
    desc = "Source current file"
  },
  {
    "<leader>fsk",
    ":source ~/.config/nvim/lua/keymaps.lua<cr>:lua print('Keymaps reloaded.')<cr>",
    desc = "Reload keymaps",
  },

  -- tabs
  { "<leader>t",  group = "[T]abs" },
  { "<leader>t_", hidden = true },
  { "<leader>t,", ":tabmove -1<cr>",         desc = "Rearrange current tab to the left" },
  { "<leader>t.", ":tabmove +1<cr>",         desc = "Rearrange current tab to the right" },
  { "<leader>t1", "1gt",                     desc = "Enter tab #1" },
  { "<leader>t2", "2gt",                     desc = "Enter tab #2" },
  { "<leader>t3", "3gt",                     desc = "Enter tab #3" },
  { "<leader>t4", "4gt",                     desc = "Enter tab #4" },
  { "<leader>t5", "5gt",                     desc = "Enter tab #5" },
  { "<leader>t6", "6gt",                     desc = "Enter tab #6" },
  { "<leader>t7", "7gt",                     desc = "Enter tab #7" },
  { "<leader>t8", "8gt",                     desc = "Enter tab #8" },
  { "<leader>t9", "9gt",                     desc = "Enter tab #9" },
  { "<leader>tq", ":tabclose<cr>",           desc = "[Q]uit current tab" },
  { "<leader>tt", ":tabedit<cr>",            desc = "Open new [t]ab" },

  -- UI
  { "<leader>u",  group = "[U]ser Interface" },
  { "<leader>u_", hidden = true },
  { "<leader>uN", ":NoNeckPain<cr>",         desc = "Toggle [N]oNeckPain" },
  {
    "<leader>uW",
    function() -- TODO: extract and name
      local wrap = vim.o.wrap
      vim.o.wrap = not wrap
      vim.o.linebreak = not wrap
    end,
    desc = "Toggle [w]rap (text)"
  },
  { "<leader>ua", ":AerialToggle<cr>",               desc = "Toggle [A]erial" },
  {
    "<leader>uc",
    ":Telescope colorscheme sorting_strategy=ascending<cr>",
    desc = "Search [C]olorschemes"
  },
  {
    "<leader>ud",
    ":ToggleDiag<cr><c-l>:lua print('LSP diagnostics toggled.')<cr>",
    desc = "Toggle LSP [d]iagnostics",
  },
  { "<leader>ue", ":Telescope emoji<cr>",            desc = "Search for [e]moji" },
  { "<leader>ug", ":tabe<cr>:0G<cr>:tabmove -1<cr>", desc = "Open Fu[g]itive" },
  { "<leader>uh", ":set hlsearch!<cr>",              desc = "Toggle search [h]ighlight" },
  { "<leader>ui", ":IBLToggle<cr>",                  desc = "Toggle [i]ndentation guides" },
  { "<leader>ul", ":Lazy<cr>",                       desc = "Open [L]azy" },
  { "<leader>um", ":Mason<cr>",                      desc = "Open [M]ason" },
  { "<leader>un", ":set number!<cr>",                desc = "Toggle line [n]umbers" },
  { "<leader>us", ":set spell!<cr>",                 desc = "Toggle [s]pellcheck" },
  { "<leader>ut", ":NvimTreeToggle<cr>",             desc = "Toggle [T]ree" },
  { "<leader>uw", ":set wrap!<cr>",                  desc = "Toggle [w]rap" },

  -- windows
  { "<leader>w",  group = "[W]indows" },
  { "<leader>w_", hidden = true },
  { "<leader>w1", "1<c-w><c-w>",                     desc = "Enter window #1" },
  { "<leader>w2", "2<c-w><c-w>",                     desc = "Enter window #2" },
  { "<leader>w3", "3<c-w><c-w>",                     desc = "Enter window #3" },
  { "<leader>w4", "4<c-w><c-w>",                     desc = "Enter window #4" },
  { "<leader>w5", "5<c-w><c-w>",                     desc = "Enter window #5" },
  { "<leader>w6", "6<c-w><c-w>",                     desc = "Enter window #6" },
  { "<leader>w7", "7<c-w><c-w>",                     desc = "Enter window #7" },
  { "<leader>w8", "8<c-w><c-w>",                     desc = "Enter window #8" },
  { "<leader>w9", "9<c-w><c-w>",                     desc = "Enter window #9" },
  { "<leader>wS", "<c-w><c-s><c-w>j",                desc = "Create and enter split below" },
  { "<leader>wV", "<c-w><c-v><c-w>l",                desc = "Create and enter vertical split to right" },
  { "<leader>wh", "<c-w>h",                          desc = "Enter window to left" },
  { "<leader>wj", "<c-w>j",                          desc = "Enter window below" },
  { "<leader>wk", "<c-w>k",                          desc = "Enter window above" },
  { "<leader>wl", "<c-w>l",                          desc = "Enter window to right" },
  { "<leader>wo", "<c-w>o",                          desc = "Keep only the current active window" },
  { "<leader>wq", "<c-w>q",                          desc = "Quit the current active window" },
  { "<leader>wH", "<c-w>H",                          desc = "Move window all the way left" },
  { "<leader>wJ", "<c-w>J",                          desc = "Move window all the way down" },
  { "<leader>wK", "<c-w>K",                          desc = "Move window all the way up" },
  { "<leader>wL", "<c-w>L",                          desc = "Move window all the way right" },
  { "<leader>wT", "<c-w>T",                          desc = "Move window to new [T]ab" },
  { "<leader>ws", "<c-w><c-s>",                      desc = "Create split below" },
  { "<leader>wv", "<c-w><c-v>",                      desc = "Create vertical split to right" },
  { "<leader>ww", ":w<cr>",                          desc = "Write buffer in current window" },
  { "<leader>wx", ":copen<cr>",                      desc = "Open new buffer in new window" },
  { "<leader>w=", "<c-w>=",                          desc = "Make all windows equal size" },
  { "<leader>w<", "<c-w><",                          desc = "Decrease window width" },
  { "<leader>w>", "<c-w>>",                          desc = "Increase window width" },
  { "<leader>w-", "<c-w>-",                          desc = "Decrease window height" },
  { "<leader>w+", "<c-w>+",                          desc = "Increase window height" },

}

local wk_opts = {
  silent = true,
}

wk.add(wk_mappings, wk_opts)


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
