if has('win32')
  set guifont=DejaVu\ Sans\ Mono:h12
else
  set guifont=DejaVu\ Sans\ Mono:h14
endif

" Configure syntax highlighting of hex values
if exists('*HexHighlight()')
  nmap <leader>h :call HexHighlight()<Return>
endif

" Turn off toolbar, right- and left-hand scrollbars
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Source the gvimrc file after saving it. This way, you don't have to reload
" gVim to see the changes.
if has("autocmd")
  autocmd bufwritepost .gvimrc source $MYGVIMRC
endif

