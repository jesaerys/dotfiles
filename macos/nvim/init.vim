let g:python_host_prog = $HOME.'/anaconda/envs/neovim-py2/bin/python'
let g:python3_host_prog = $HOME.'/anaconda/envs/neovim-py3/bin/python'

set expandtab
set shiftwidth=4
set nowrap
set completeopt=menu,menuone,preview,longest
set clipboard+=unnamedplus

augroup ToggleNumbering
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END
set number
set relativenumber

augroup CustomHighlights
    autocmd!
    autocmd ColorScheme * :highlight Comment cterm=italic
    autocmd ColorScheme * :highlight LineNr ctermbg=None
    autocmd ColorScheme * :highlight CursorLineNr ctermbg=None
    autocmd ColorScheme * :highlight Folded ctermbg=None
augroup END
colorscheme base16-default-light

autocmd BufEnter *.pyi :set filetype=python

augroup FiletypePython
    autocmd!
    autocmd BufEnter *.py :set foldmethod=indent
    autocmd BufEnter *.py :set foldignore-=#
    autocmd FileType python let python_highlight_all = 1
    autocmd FileType python set makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
    autocmd FileType python set errorformat=%f:%l:\ %m
augroup END

nmap <C-j> ]m
nmap <C-k> [m
vmap <C-j> ]m
vmap <C-k> [m

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
