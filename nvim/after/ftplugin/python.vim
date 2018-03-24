setlocal foldmethod=indent
setlocal foldignore=-#
let python_highlight_all=1

nmap <buffer> <C-j> ]m
nmap <buffer> <C-k> [m
vmap <buffer> <C-j> ]m
vmap <buffer> <C-k> [m

" This makes pylint a runtime dependency; may not always have pylint available.
"setlocal makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
"setlocal errorformat=%f:%l:\ %m
