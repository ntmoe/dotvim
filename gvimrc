if has('win32')
  set guifont=DejaVu\ Sans\ Mono:h10
elseif has('mac')
  set guifont=Menlo:h12
  " Configure touch bar
  " Pushes the full-screen butten over to the right so I don't accidentally
  " touch it when I go to press escape
  " From https://github.com/macvim-dev/macvim/issues/1175#issuecomment-796113914
  an 1.1 TouchBar.-flexspace1- <Nop>
  " NERDTree toggle
  " From https://gist.github.com/mdennehy/8f373a235222a1e8a6adaaad164a1ba8
  an icon=NSTouchBarSidebarTemplate TouchBar.NerdTree :NERDTreeToggle<CR>
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

