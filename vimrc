set nocompatible
syntax enable         " Turn on syntax highlighting allowing local overrides
filetype off
if exists('portable')
  set rtp+=~/.vim/bundle/vundle/
elseif has('win32')
  set rtp+=~/vimfiles/bundle/vundle/
else
  set rtp+=~/.vim/bundle/vundle/
endif
call vundle#rc()
Bundle 'gmarik/vundle'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'othree/html5.vim'
" Bundle 'hail2u/vim-css3-syntax'
Bundle 'skammer/vim-css-color'
" Bundle 'vim-scripts/TuttiColori-Colorscheme'
Bundle 'hexHighlight.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-surround'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'msanders/snipmate.vim'
Bundle 'Townk/vim-autoclose'
Bundle 'plasticboy/vim-markdown'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/nerdtree'
filetype plugin indent on

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

""
"" Helpers
""

" Some file types should wrap their text
" See http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
function! SetupWrapping()
  set wrap
  set linebreak
  set textwidth=0
  set wrapmargin=0
  set nolist
endfunction

if has("gui_running")
  if has("autocmd")
    " Automatically resize splits when resizing MacVim window
    autocmd VimResized * wincmd =
  endif
endif

""
"" Basic Setup
""

set number            " Show line numbers
set ruler             " Show line and column number
set encoding=utf-8    " Set default encoding to UTF-8

""
"" Whitespace
""
if exists("+breakindent")
    setlocal breakindent
endif

" set wrap
" set nowrap                      " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen

""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

""
"" Backup and swap files
""

set backupdir=~/.vim/_backup//    " where to put backup files.
set directory=~/.vim/_temp//      " where to put swap files.

""
"" Status line settings
""

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  " Without setting this, ZoomWin restores windows in a way that causes
  " equalalways behavior to be triggered the next time CommandT is used.
  " This is likely a bludgeon to solve some other issue, but it works
  set noequalalways

  " Start the status line
  set statusline=%f\ %m\ %r

  " Finish the statusline
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

""
"" Color scheme settings
""

set background=dark
colorscheme solarized

""
"" Enable the mouse, but don't change the settings if this is a GUI.
""

if has('mouse') && !has('gui_running')
  set mouse=a
endif

" Source the vimrc file after saving it. This way, you don't have to reload
" Vim to see the changes.
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Map escape key to jj -- much faster
imap jj <esc>

"" Markdown to HTML
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>

" Faster shortcut for commenting. Requires T-Comment plugin
map <leader>c <c-_><c-_>

" Saves time; maps the spacebar to colon
nmap <space> :

""
"" File types
""

filetype plugin indent on " Turn on filetype plugins (:help filetype-plugin)

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " This actually might be confusing, but the plugin +ruby+ already does
  " this, so we want to do it only if the plugin +ruby+ is disabled for
  " some reason
  " if janus#is_plugin_disabled("ruby")
      " Set the Ruby filetype for a number of common Ruby files without .rb
  "   au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,config.ru,*.rake} set ft=ruby
  " endif

  " Make sure all markdown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} setf markdown | call s:setupWrapping()

  au BufRead,BufNewFile *.{tex,txt} call SetupWrapping()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif
