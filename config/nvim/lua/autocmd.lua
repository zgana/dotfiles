-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
-- https://neovim.discourse.group/t/a-lua-based-auto-refresh-buffers-when-they-change-on-disk-function/2482/5
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Recognize Markdown bullets (-, *, +), numbered lists, and checkboxes
    vim.opt_local.formatlistpat = [[^\s*\([-*+]\s\(\[[ xX]\]\s\)\?\|\d\+\.\)\s\+]]

    -- Enable wrapping & indent
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.breakindentopt = { "shift:2", "list:-1" }
    vim.cmd [[setlocal formatoptions+=2]]

    -- Optional visual marker for wrapped lines
    -- vim.opt_local.showbreak = "↳ "

    vim.opt_local.textwidth = 0
  end,
})
