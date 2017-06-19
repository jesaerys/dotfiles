let g:python_host_prog = $HOME.'/anaconda/envs/neovim-py2/bin/python'
let g:python3_host_prog = $HOME.'/anaconda/envs/neovim-py3/bin/python'

set expandtab
set shiftwidth=4
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

augroup FiletypePython
    autocmd!
    autocmd BufEnter *.py :set foldmethod=indent
    autocmd BufEnter *.py :set foldignore-=#
    autocmd BufEnter *.py :let python_highlight_all=1
augroup END

nmap <C-j> ]m
nmap <C-k> [m
vmap <C-j> ]m
vmap <C-k> [m
