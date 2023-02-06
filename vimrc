"""
""" vim-plug
"""

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/altercation/solarized
Plug 'altercation/solarized', { 'rtp': 'vim-colors-solarized' }

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" LaTeX
Plug 'lervag/vimtex'

" VIM Table Mode
Plug 'dhruvasagar/vim-table-mode'

" vim-crbasic
Plug 'bearnik/vim-crbasic'

" extline
Plug 'drmikehenry/vim-extline'

" vimspector
Plug 'puremourning/vimspector'

" Initialize plugin system
call plug#end()

filetype plugin indent on " Turn on filetype plugins (:help filetype-plugin) 

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

""
"" Key Mappings
""

" Map escape key to jj -- much faster
imap jj <esc>

" Saves time; maps the spacebar to colon
nmap <space> :


""
"" Mouse for Terminal Mode
""

" Enable the mouse, but don't change the settings if this is a GUI.
if has('mouse') && !has('gui_running')
  set mouse=a
endif


""
"" Color scheme settings
""

set background=dark
colorscheme solarized


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
    set breakindent
endif

" set wrap
" set nowrap                      " don't wrap lines
" set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set softtabstop=2
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
set fileformat=unix
set nojoinspaces                  " Prevent vim from inserting a second space when joining lines

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

" set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

""
"" Backup and swap files
""

" set backupdir=~/.vim/_backup    " where to put backup files.
" set directory=~/.vim/_temp      " where to put swap files.

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
  set statusline+=\ Col:%v
  set statusline+=\ Buf:#%n
  set statusline+=\ Char:[%b][0x%B]
endif


" Source the vimrc file after saving it. This way, you don't have to reload
" Vim to see the changes.
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif


"" Markdown to HTML
" nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>

" Faster shortcut for commenting. Requires T-Comment plugin
" map <leader>c <c-_><c-_>


""
"" Markdown (plasticboy/vim-markdown)
""

" Disable the folding configuration for Markdown
let g:vim_markdown_folding_disabled = 0

" To enable/disable folding use Vim's standard folding configuration.
" set [no]foldenable

" Fold in a style like python-mode
" let g:vim_markdown_folding_style_pythonic = 1

" Prevent foldtext from being set
let g:vim_markdown_override_foldtext = 0

" Set header folding level
" Folding level is a number between 1 and 6. By default, if not specified, it
" is set to 1.
let g:vim_markdown_folding_level = 1

"""
""" LaTeX (verlag/vimtex)
"""

" Set the viewer method.
let g:vimtex_view_method = 'skim'


""
"" File types
""

if has("autocmd")
  " Some file types should wrap their text
  " See http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
  function! SetupWrapping()
    set wrap
    set linebreak
    set textwidth=0
    set wrapmargin=0
    set nolist
  endfunction

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
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} setf markdown | call SetupWrapping()
  
  au BufRead,BufNewFile *.{tex,txt} call SetupWrapping()

  " Set syntax highlighting for CRBasic files
  au BufRead,BufNewFile *.{CR300,cr1,cr6} set filetype=freebasic

  " Treat JSON files like JavaScript
  " au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  " au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  "   \| exe "normal! g`\"" | endif
endif

" Set up Lilypond plugin, indent mode, and syntax-highlighting
if has('mac')
  filetype off
  set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim
  filetype on
endif

" Set up make
set makeprg=gcc\ -Wall\ -o\ %:r\ %

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Abbreviations to make constructing boxes for C comments easier
:abbr #b /********************************************************
    " When on the last line of the box, we need to back up one space
:abbr #e <Backspace>*******************************************************/

" Options for VIM Table Mode
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

" Options for netrw to make it work like NERDtree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25

" Configuration for vimspector
let g:vimspector_enable_mappings = 'HUMAN'
