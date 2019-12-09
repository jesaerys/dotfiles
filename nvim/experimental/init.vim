" vim: foldmethod=marker

" Plugins {{{1
" These are only required when using remote python2/3 plugins. Do I really
" need these? I think nvr uses py3.
"let g:python_host_prog = expand('~/.local/share/nvim-python/python2.7-env/bin/python')
"let g:python3_host_prog = expand('~/.local/share/nvim-python/python3.7-env/bin/python')


" Editing {{{1
set expandtab
set shiftwidth=4
set nowrap
set nojoinspaces

function! PadLine(char, n)
    " Repeatedly append char to a line out to column n.

    " Temporarily disable auto-wrapping
    let originalFormatOptions = &formatoptions
    set formatoptions-=c
    set formatoptions-=t

    exec 'normal! ' . a:n . 'A' . a:char
    exec 'normal! d' . a:n . '|'

    let &formatoptions=originalFormatOptions
endfunction


" Navigation and searching {{{1
set inccommand=split

" - easymotion?
" - sneak? (Idea: bind sneak to f/F/t/T instead of s)


" Files and buffers {{{1
set path+=**  " Turn :find into a light fuzzy finder

" - fzf?
" - dirvish/vinegar?
" - Easily rename a file that is loaded in a buffer without closing it?


" Windows {{{1
nnoremap <C-w><C-h> :vertical lefta split<CR>
nnoremap <C-w><C-j> :below split<CR>
nnoremap <C-w><C-k> :above split<CR>
nnoremap <C-w><C-l> :vertical rightb split<CR>


" Command-line mode and completion {{{1
nnoremap q; q:i
set wildmode=longest:full
set completeopt=menu,menuone,preview,longest

" - skybison?
" - unite/denite?
" - deoplete?
" - Keep watching the integration of Language Server Protocol, which will
"   replace completion plugins
"   - https://github.com/neovim/neovim/issues/5522 and
"     https://github.com/neovim/neovim/pull/6856
"   - https://github.com/autozimu/LanguageClient-neovim
"   - https://fortes.com/2017/language-server-neovim/


" Terminal mode {{{1
tnoremap <C-Space> <C-\><C-n>
tnoremap <C-w> <C-\><C-n><C-w>
autocmd BufEnter term://* startinsert
autocmd TermOpen * startinsert

" - Can't edit the command line in a terminal buffer using Normal mode
"   commands. It's better to use the shell's vim emulation for command line
"   editing.
"
" - Note that terminals open non-login, interactive shells. For bash, this
"   means bash_profile is *not* sourced. To get consistent behavior between
"   login and non-login shells, use bashrc and source it from bash_profile.
"
" - Keep terminal alive when switching to other buffers?
"
" - Send current line or selection to the last visited terminal buffer?
"
" - Find an easier way to write ad-hoc terminal interaction commands like this
"   one from Modern Vim,
"
"     :command! Restart call jobsend(1, "\<C-c>npm run server\<CR>")
"
"   where the 1 is the job ID from,
"
"     :echo b:terminal_job_id
"
"   For instance, it might be useful to have a higher order command that takes
"   a name and a terminal command string as arguments and builds a new command
"   with the given name using the job ID of the current buffer.
"   Or, maybe I just get more comfortable with vimscript and build such
"   commands as I need them.
"
" - Use neovim-remote to open files from the terminal? E.g., see
"   https://www.reddit.com/r/neovim/comments/6mkvo3/builtin_terminals_or_tmux/dk2db7p/
"
" - Distinguish vim's cursor from the shell's cursor? Here's an example from
"   Modern Vim,
"
"     highlight! link TermCursor Cursor
"     highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
"
"   The defaults are,
"
"     TermCursor cterm=reverse gui=reverse
"     TermCursorNC cleared
"


" Keyboard {{{1
map <Space> <Leader>

" - vim-submode?


" TUI {{{1

" Clipboard {{{2
set clipboard+=unnamedplus

" Block paste is currently broken with clipboard=unnamed (see
" https://github.com/neovim/neovim/issues/1822). A workaround is to yank/paste
" with a named register.
" - nvim-miniyank?

" Mouse {{{2
set mouse=a  " mouse=a enables trackpad scrolling

" Folding {{{2
set foldtext=getline(v:foldstart)
set foldopen-=block
set foldopen+=jump
set foldtext=getline(v:foldstart)

" UI elements {{{2
" fillchars vert (vertical window separator) and fold (fold fill) have
" reasonable defaults as long as ambiwidth is set to single, which it is by
" default on my system

" Colors {{{2
set termguicolors

augroup HighlightOverrides
    autocmd!
    autocmd ColorScheme * :highlight Comment gui=italic
    autocmd ColorScheme * :highlight Folded guibg=NONE
    autocmd ColorScheme * :highlight VertSplit gui=NONE
augroup END

colorscheme default
syntax off

" - Use a syntax/colorscheme file instead of an augroup?
" - Can wildmenu be turned into a mini window with one result per line?
" - vim-better-whitespace?


" Goals and TODO {{{1
"
" - Better autoindenting (next line in Python, dedent closing paren on new line, ...)?
"
" - Auto-closing pairs, e.g., parens (and type over the closing character)?
"
" - Only apply certain "gui" settings when running in terminal? Unless Oni is
"   smart enough to ignore such settings automatically.
"
" - Motion command to move up/down to the next non-whitespace character in the
"   same column?
"
" - split/vsplit opens a new window above/to the left of the current window.
"   Can I have them do below/to the right of instead (like tmux)?
"
" - make file search path recursive from pwd (see tip in 'vim without plugins'
"   video)
"
" - efficiently find/open files
"   - fuzzy finding a la fzf? Ideally something like cmd-p in vscode which
"     automatically populates the previous hit.
"
" - switch/manage buffers
"
" - manage files
"   - especially renaming/moving a file that's already in a buffer
"
" - navigate large codebases
"
" Things to think about:
"
" - Manage plugins manually? With minpac? Something else, e.g., Plug?
"
" - Leveraging quickfix?
"
" - emacs' which-key for vim?
"
" - Spacemacs-inspired shortcuts?
