if has('win32')
  set guifont=DejaVu\ Sans\ Mono:h10
elseif has('mac')
  set guifont=Menlo:h12
else
  set guifont=DejaVu\ Sans\ Mono:h12
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

if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

if has("autocmd")
  " Automatically resize splits when resizing MacVim window
  autocmd VimResized * wincmd =
  
  " Source the gvimrc file after saving it. This way, you don't have to reload
  " gVim to see the changes.
  autocmd bufwritepost .gvimrc source $MYGVIMRC
endif

