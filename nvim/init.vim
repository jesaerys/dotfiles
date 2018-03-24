" Neovim details ---------------------------------------------------------------
let g:python_host_prog  = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" For more responsive escape key
set nottimeout


" Plugins ----------------------------------------------------------------------
if filereadable(expand('~/.local/share/nvim/site/autoload/plug.vim'))
    call plug#begin('~/.local/share/nvim/plugged')
    Plug 'albertorestifo/github.vim'
    call plug#end()
endif


" Leader -----------------------------------------------------------------------
map <Space> <Leader>
nnoremap <Leader>w :w<CR>
nnoremap <Leader><Space> :
nnoremap <Leader>h :help 
nnoremap <Leader>hh :help 
nnoremap <Leader>hg :helpgrep 
nnoremap <Leader>s :set 
nnoremap <Leader>m :make<CR>


" Editing ----------------------------------------------------------------------
set expandtab
set shiftwidth=4
set nowrap
set nojoinspaces

function! PadLine(char, n)
    " Append char to a line out to column n.

    " Temporarily disable auto-wrapping
    let originalFormatOptions = &formatoptions
    if match(&formatoptions, 'c') >= 0
        set formatoptions-=c
    endif
    if match(&formatoptions, 't') >= 0
        set formatoptions-=t
    endif

    exec 'normal! $' . a:n . 'A' . a:char
    exec 'normal! d' . a:n . '|'

    let &formatoptions=originalFormatOptions
endfunction

" * Keep watching the integration of Language Server Protocol, which will
"   replace completion plugins
"   - https://github.com/neovim/neovim/issues/5522
"   - https://github.com/autozimu/LanguageClient-neovim
"   - https://fortes.com/2017/language-server-neovim/


" Completion -------------------------------------------------------------------
set completeopt=menu,menuone,preview,longest
" * deoplete?
" * unite?


" Clipboard --------------------------------------------------------------------
set clipboard+=unnamedplus  " Unresolved issue: block paste is broken with
                            " clipboard=unnamed (see #1822). An alternative is
                            " to yank/paste with a named register. Maybe check
                            " out nvim-miniyank?


" Searching --------------------------------------------------------------------
set inccommand=split
" * easymotion?


" Files and buffers ------------------------------------------------------------
set path+=**  " Turn :find into a light fuzzy finder. (Try fzf?)
nnoremap <Leader>b :b 
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
" * dirvish/vinegar?
" * vim-better-whitespace?
" * Easily rename a file that is loaded in a buffer without closing it?


" Command-line mode ------------------------------------------------------------
nnoremap q; q:i
set wildmode=longest:full
" * Can wildmenu be turned into a mini window with one result per line?
" * skybison?
" * unite?


" Windows ----------------------------------------------------------------------
nnoremap <C-w><C-h> :vertical lefta split<CR>
nnoremap <C-w><C-j> :below split<CR>
nnoremap <C-w><C-k> :above split<CR>
nnoremap <C-w><C-l> :vertical rightb split<CR>
" * Send text (object+motion or visual selection) to another window?


" Quick fix --------------------------------------------------------------------
nnoremap <Leader>c :below cwindow<CR><ESC>
nnoremap <Leader>cw :below cwindow<CR><ESC>
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprevious<CR>
" * Can a "quickfix-mode" be defined for these things? E.g., I'd rather type
"   enter the mode once and press "nnn..." to quickly go through the quickfix
"   items, rather than "<Leader>cn" for every single item.
"   (Check out github.com/kana/vim-submode?)
" * neomake?


" Terminals --------------------------------------------------------------------
tnoremap <C-Space> <C-\><C-n>
tnoremap <C-w> <C-\><C-n><C-w>
autocmd BufEnter term://* startinsert
autocmd TermOpen * startinsert
nnoremap <Leader>t :term<CR>
" * Note that terminals open non-login, interactive shells. For bash, this
"   means bash_profile is *not* sourced. To get consistent behavior between
"   login and non-login shells, use bashrc and source it from bash_profile.
" * Use neovim-remote to open files from the terminal? E.g., see
"   https://www.reddit.com/r/neovim/comments/6mkvo3/builtin_terminals_or_tmux/dk2db7p/


" UI ---------------------------------------------------------------------------
"augroup ToggleNumbering
"    autocmd!
"    autocmd InsertEnter * :set norelativenumber
"    autocmd InsertLeave * :set relativenumber
"augroup END
"set number
"set relativenumber

set foldtext=getline(v:foldstart)
set fillchars=vert:│,fold:╌
set foldopen-=block

set termguicolors

" * Is an augroup the best way? What about a syntax file?
augroup CustomHighlights
    autocmd!
    autocmd ColorScheme * :highlight Comment gui=italic
    autocmd ColorScheme * :highlight Folded guibg=NONE
    autocmd ColorScheme * :highlight VertSplit gui=NONE guifg=#c2c2c2
    autocmd ColorScheme * :highlight StatusLine gui=bold guifg=#ffffff guibg=#373737
    autocmd ColorScheme * :highlight StatusLineNC gui=NONE guifg=#ffffff guibg=#373737
augroup END

if filereadable(expand('~/.local/share/nvim/site/autoload/plug.vim'))
    colorscheme github
else
    colorscheme default
endif
