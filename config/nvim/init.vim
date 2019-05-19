
" Section: Load Dein and plugins {{{

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim
set runtimepath+=$HOME/.config/nvim
set runtimepath+=$HOME/.fzf

" Required:
if dein#load_state($HOME . '/.cache/dein')
    call dein#begin($HOME . '/.cache/dein')

    " Let dein manage dein
    " Required:
    call dein#add($HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim')

    " Airline
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    " dir and file hierarchy
    call dein#add('scrooloose/nerdtree')
    " minimap (super ridiculous, do not use)
    "call dein#add('severin-lemaignan/vim-minimap')

    " fzf
    call dein#add('junegunn/fzf.vim')

    " Completion
    call dein#add('SirVer/ultisnips')
    " call dein#add('honza/vim-snippets')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('ervandew/supertab')

    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/neco-vim')
    call dein#add('Shougo/deoplete-clangx')
    call dein#add('Shougo/neoinclude.vim')
    call dein#add('zchee/deoplete-jedi')

    call dein#add('davidhalter/jedi-vim')
    call dein#add('davidhalter/jedi')

    " Refactoring
    "call dein#add('python-rope/ropevim')
    call dein#add('tpope/vim-commentary')
    call dein#add('terryma/vim-multiple-cursors')

    " Colors
    " TODO: prune
    call dein#add('bcicen/vim-vice')
    call dein#add('juanedi/predawn.vim')
    call dein#add('mhinz/vim-janah')
    call dein#add('jnurmine/Zenburn')
    call dein#add('flazz/vim-colorschemes')
    call dein#add('altercation/vim-colors-solarized')

    " Filetypes
    call dein#add('lervag/vimtex')
    "call dein#add('JuliaEditorSupport/julia-vim')

    " Tags
    "call dein#add('ludovicchabant/vim-gutentags')
    "call dein#add('majutsushi/tagbar')

    " You can specify revision/branch/tag.
    " (just an example)
    call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

"End dein Scripts-------------------------
" }}}

" Section: General editor settings {{{
let mapleader = ' '
let maplocalleader = '\'
map <s-space> <leader>

set autoread
set cursorline
set expandtab
set hidden
set ignorecase smartcase
set incsearch
set joinspaces
set magic
set modeline
set noerrorbells
set nohlsearch
set ruler
set undofile
set wildmenu

set backspace=eol,indent,start
set browsedir=current
set bufhidden=hide
set cinoptions=(0,g0,t0,Ws,*200,:0,)200
set completeopt=menuone
set formatoptions+=tcqnjr
set grepprg=grep\ -nH\ $*
set nrformats=
set shiftwidth=4
set softtabstop=4
set tabstop=8
set textwidth=79
set undodir="${HOME}.vim/undo"
set undolevels=1000
set undoreload=10000
set virtualedit=block
set wildignore=*.o
set wildmode=list:longest

silent call system ('mkdir -p $HOME/.vim/undo')

" }}}

" Section: Appearance {{{

let g:airline_powerline_fonts = 1

function! WN(...)
    let builder = a:1
    let context = a:2
    call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
    return 0
endfunction

if !exists("g:mdr_conf_winnum")
    call airline#add_statusline_func('WN')
    call airline#add_inactive_statusline_func('WN')
    let g:mdr_conf_winnum="yes"
endif

" }}}

" Section: FZF configuration {{{
let g:fzf_layout = {'down': '20%', }
command! -bang Colors
            \ call fzf#vim#colors({'left': '20%', 'options': '--reverse --margin 5%,0'}, <bang>0)
command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>,
            \                 <bang>0 ? fzf#vim#with_preview('up:40%')
            \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
            \                 <bang>0)

" }}}

" Section: Editing with word wrap {{{
function! g:Wordwrap_begin()
    noremap j	gj
    noremap k	gk
    noremap A	g$a
    noremap C       cg$
    noremap I	g^i
    noremap 0	g0
    noremap ^	g^
    noremap $	g$
    noremap G	G$g^
    setlocal linebreak
    let b:wordwrap_tw = &tw
    setlocal tw=0
    highlight OverLength NONE
    echo "Now using word wrap..."
    let b:wordwrap_is_on = 1
endfunction
function! g:Wordwrap_end()
    unmap j
    unmap k
    unmap A
    unmap C
    unmap I
    unmap 0
    unmap ^
    unmap $
    unmap G
    setlocal nolinebreak
    let &tw = b:wordwrap_tw
    highlight OverLength ctermbg=red ctermfg=white guibg=#FFB9B9
    echo "No longer using word wrap..."
    let b:wordwrap_is_on = 0
endfunction
function! g:Wordwrap_toggle()
    if b:wordwrap_is_on
        call g:Wordwrap_begin()
    else
        call g:Wordwrap_end()
    endif
endfunction
" }}}

" Section: SPC mappings {{{
" Files {{{
" general
noremap <leader>f. :e .<cr>
noremap <leader>ff :Files<cr>
noremap <leader>fF :Files 
noremap <leader>fd1 :cd %:p:h<cr>:pwd<cr>
noremap <leader>fd2 :cd %:p:h<cr>:cd ..<cr>:pwd<cr>
noremap <leader>fd3 :cd %:p:h<cr>:cd ../..<cr>:pwd<cr>
noremap <leader>fdp :pwd<cr>
noremap <leader>fyy :echo expand('%:p')<cr>
" config
noremap <leader>fif :e ~/.config/nvim/init.vim<cr>
noremap <leader>fgf :e ~/.config/nvim/ginit.vim<cr>
noremap <leader>fiF <c-w><c-v><c-w>l:e ~/.config/nvim/init.vim<cr>
noremap <silent><leader>fis :so ~/.config/nvim/init.vim<cr>:echo "init.vim reloaded."<cr>
noremap <silent><leader>fiS :so ~/.config/nvim/init.vim<cr>:so ~/.config/nvim/ginit.vim<cr>:echo "init.vim reloaded."<cr>
" }}}
" Buffers {{{
"map <leader>b :ls<cr>:b 
noremap <leader>ba :Buffers<cr>
noremap <leader>bb :History<cr>
noremap <leader>bs :w<cr>
" }}}
" Windows {{{
" create splits
noremap <leader>wv <c-w><c-v>
noremap <leader>wV <c-w><c-v><c-w>l
noremap <leader>ws <c-w><c-s>
noremap <leader>wS <c-w><c-s><c-w>j
" switch splits
noremap <leader>1 1<c-w><c-w>
noremap <leader>2 2<c-w><c-w>
noremap <leader>3 3<c-w><c-w>
noremap <leader>4 4<c-w><c-w>
noremap <leader>5 5<c-w><c-w>
noremap <leader>6 6<c-w><c-w>
noremap <leader>7 7<c-w><c-w>
noremap <leader>8 8<c-w><c-w>
noremap <leader>9 9<c-w><c-w>
noremap <leader>w1 1<c-w><c-w>
noremap <leader>w2 2<c-w><c-w>
noremap <leader>w3 3<c-w><c-w>
noremap <leader>w4 4<c-w><c-w>
noremap <leader>w5 5<c-w><c-w>
noremap <leader>w6 6<c-w><c-w>
noremap <leader>w7 7<c-w><c-w>
noremap <leader>w8 8<c-w><c-w>
noremap <leader>w9 9<c-w><c-w>
noremap <leader>ww <c-w><c-w>
noremap <leader>wh <c-w>h
noremap <leader>wj <c-w>j
noremap <leader>wk <c-w>k
noremap <leader>wl <c-w>l
noremap <leader>wq <c-w><c-q>
noremap <leader>wd <c-w><c-q>
noremap <leader>wo <c-w><c-o>
" }}}
" Tabs {{{
noremap <leader>t1 1gt
noremap <leader>t2 2gt
noremap <leader>t3 3gt
noremap <leader>t4 4gt
noremap <leader>t5 5gt
noremap <leader>t6 6gt
noremap <leader>t7 7gt
noremap <leader>t8 8gt
noremap <leader>t9 9gt
noremap <leader>t, :tabmove -1<cr>
noremap <leader>t. :tabmove +1<cr>
noremap <leader>tt :tabedit<cr>
noremap <leader>te :tabedit<cr>:Files<cr> 
noremap <leader>tE :tabedit<cr>:Files
noremap <leader>tq :tabclose<cr>
" }}}
" Project {{{
noremap <leader>pt :NERDTreeToggle<cr>
noremap <leader>pp :NERDTreeVCS<cr>
noremap <leader>pf :NERDTreeFind<cr>
" }}}
" Minimap {{{
" let g:minimap_show='<leader>Mo'
" let g:minimap_update='<leader>Mu'
" let g:minimap_close='<leader>Mc'
" let g:minimap_toggle='<leader>Mt'
" }}}
" Search {{{
noremap <leader>ss :BLines<cr>
noremap <leader>so :Lines<cr>
noremap <leader>sa :Ag<cr>
noremap <leader>sA :Ag!<cr>
noremap <leader>sc :History:<cr>
noremap <leader>s/ :History/<cr>
noremap <leader>sm :Maps<cr>
noremap <leader>sn :Snippets<cr>
" }}}
" Yank {{{
" general system clipboard copy
noremap	<leader>y "+y

" whole-file copy suitable for gmail
" the following should work, but doesn't for unknown reasons:
"noremap	<leader>yg :%yank +<cr>
" instead, we need the following:
noremap	<leader>yg :!pyxclip-i %<cr><c-l>
" which relies on a little script that looks like:
"#!/usr/bin/env python3
"import pyperclip
"import sys
"filename = sys.argv[1]
"with open (filename) as f:
"    pyperclip.copy (f.read ())
" }}}
" Theme {{{
noremap <leader>TA :AirlineTheme 
noremap <leader>TC :Colors<cr>
" }}}
" Multicursor {{{
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<leader>*'
let g:multi_cursor_select_all_word_key = '<leader>!*'
let g:multi_cursor_start_key           = '<leader>g*'
let g:multi_cursor_select_all_key      = '<leader>!g*'
let g:multi_cursor_next_key            = '<m-*>'
let g:multi_cursor_prev_key            = '<m-#>'
let g:multi_cursor_skip_key            = '<m-^>'
let g:multi_cursor_quit_key            = '<esc>'
" }}}
" Toggles {{{
noremap <leader>on :set number! relativenumber!<cr>
noremap <leader>op :call AutoPairsToggle()<cr>
" TODO: figure out how to actually toggle
noremap <leader>ow :call g:Wordwrap_begin()<cr>
noremap <leader>oW :call g:Wordwrap_end()<cr>
" }}}
" Snippets {{{
noremap <leader>SR :call UltiSnips#RefreshSnippets()<cr>
" }}}
" Quit {{{
noremap <leader>qq :qa<cr>
noremap <leader>qw :wqa<cr>
" }}}
" Help {{{
noremap <leader>hh :Helptags<cr>
noremap <leader>hk :map <lt>leader>
noremap <leader>hv :vert help 
noremap <leader>hV :vert bo help 
noremap <leader>hff :split! ~/.config/nvim/init.vim<cr>gg/^" Files <cr>zMzvzt
noremap <leader>hbb :split! ~/.config/nvim/init.vim<cr>gg/^" Buffers <cr>zMzvzt
noremap <leader>hww :split! ~/.config/nvim/init.vim<cr>gg/^" Windows <cr>zMzvzt
noremap <leader>htt :split! ~/.config/nvim/init.vim<cr>gg/^" Tabs <cr>zMzvzt
noremap <leader>hpp :split! ~/.config/nvim/init.vim<cr>gg/^" Project <cr>zMzvzt
noremap <leader>hss :split! ~/.config/nvim/init.vim<cr>gg/^" Search <cr>zMzvzt
noremap <leader>hyy :split! ~/.config/nvim/init.vim<cr>gg/^" Yank <cr>zMzvzt
noremap <leader>hTT :split! ~/.config/nvim/init.vim<cr>gg/^" Theme <cr>zMzvzt
noremap <leader>hMM :split! ~/.config/nvim/init.vim<cr>gg/^" Multicursor <cr>zMzvzt
noremap <leader>hoo :split! ~/.config/nvim/init.vim<cr>gg/^" Toggles <cr>zMzvzt
noremap <leader>hSS :split! ~/.config/nvim/init.vim<cr>gg/^" Snippets <cr>zMzvzt
noremap <leader>hQQ :split! ~/.config/nvim/init.vim<cr>gg/^" Quit <cr>zMzvzt
noremap <leader>HH  :split! ~/.config/nvim/init.vim<cr>gg/^" Help <cr>zMzvzt
" }}}
" Timeout {{{
set timeoutlen=10000
" }}}
" Command mode tweaks {{{
cnoremap <c-p> <up>
cnoremap <c-n> <down>
" }}}
" }}}

" Section: Completion {{{
"inoremap <c-n> <c-x><c-n>
"inoremap <c-p> <c-x><c-p>
let g:jedi#completions_enabled = 0
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete_delay', 3000)
" }}}

" Section: auto-pairs {{{
let g:AutoPairsShortcutJump = "<c-j>"
" }}}

" Section: Snippets {{{
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<m-=>"
let g:UltiSnipsJumpForwardTrigger="<m-.>"
let g:UltiSnipsJumpBackwardTrigger="<m-,>"

" }}}

" Section: Autocmd {{{

" mimic autochdir
autocmd BufEnter * silent! lcd %:p:h
autocmd BufEnter * silent! let b:wordwrap_is_on = 0

" LaTeX {{{
function! MDR_tex()
    setlocal shiftwidth=2
    setlocal textwidth=90
endfunction
autocmd BufEnter *.tex silent! call MDR_tex()
"}}}
" Python {{{
function! MDR_py()
    let g:jedi#completions_command = "<c-n>"
    let g:jedi#goto_command = "<leader>mgg"
    let g:jedi#goto_assignments_command = "<leader>mga"
    let g:jedi#documentation_command = "<leader>mvd"
    let g:jedi#rename_command = "<leader>mr"
    let g:jedi#usages_command = "<leader>mvu"
    noremap <leader>mvm :Pyimport 
    noremap <leader>mgg :call jedi#goto()<cr>
    noremap <leader>mga :call jedi#goto_assignments()<cr>
    noremap <leader>mvd :call jedi#show_documentation()<cr>
    noremap <leader>mr  :call jedi#rename()<cr>
    noremap <leader>mvu :call jedi#usages()<cr>
    noremap <localleader>vm :Pyimport
    noremap <localleader>gg :call jedi#goto()<cr>
    noremap <localleader>ga :call jedi#goto_assignments()<cr>
    noremap <localleader>vd :call jedi#show_documentation()<cr>
    noremap <localleader>r  :call jedi#rename()<cr>
    noremap <localleader>vu :call jedi#usages()<cr>
    setlocal tw=90
endfunction
autocmd BufEnter *.py silent! call MDR_py()
" }}}
" C++ {{{
function! MDR_cpp()
    setlocal tw=90
    setlocal foldmethod=syntax
endfunction
autocmd BufEnter *.cpp,*.cxx,*.cc,*.C silent! call MDR_cpp()
" }}}

" }}}

runtime local/init.vim

" vim: set fdm=marker:
