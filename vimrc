"""dlx's vimrc"""

"""-------------------------------------------"""
"""                    INIT             """
"""-------------------------------------------"""
" Required here because of Vundle interaction
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required
Plugin 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'szw/vim-tags'
Plugin 'justinmk/vim-sneak'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'cdmedia/itg_flat_vim'
Plugin 'wting/rust.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'ludovicchabant/vim-gutentags'

" All of your Plugins must be added before the following line
call vundle#end()

"Handles filetype detection
if has("autocmd")
  filetype on
  filetype indent on
  filetype plugin on
endif

"Makes window big in gvim
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=60 columns=90
endif

"Turn terminal color on
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
endif

"tmux configs
if (exists('$TMUX'))
    set t_Co=256
endif

"""-------------------------------------------"""
"""          BUILT IN FUNCTIONALITY           """
"""-------------------------------------------"""

"Built in settings
syntax on
colorscheme itg_flat
fixdel                    "Sometimes hitting backspace in :command prints ^* instead
set nu
set ruler                 "Always shows info on bottom
set cursorline            "Highlight current line
set visualbell
set noerrorbells
set showmode
set showcmd               "Shows partially completed commands
set autoindent
set ignorecase            "Ignores case in searches
set smartcase             "Case sensitive if search starts with uppercase
set incsearch             "Incremental search
set showmatch             "Highlight matching bracket
set ts=2                  "Sets a tab to be 2 spaces
set shiftwidth=2          "Makes the >> width 2
set softtabstop=2         "Number of insert mode columns for a tab when tab is hit"
set expandtab             "Spaces instead of tabs
set backspace=indent,eol,start  "More powerful backspace
set guioptions-=T         "Hide GUI toolbar
set laststatus=2          "Airline config: Makes airline show up w/o needing a split

"Remaps
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>l :call Line_Number_Toggle()<CR>
nmap <F4> :TagbarToggle<CR>
nmap <Leader>e <plug>NERDTreeTabsToggle<CR>
imap jj <Esc>
nmap <C-n> :tabn<CR>
nmap <C-p> :tabp<CR>
nnoremap j gj
nnoremap k gk
map <C-J> <C-w>j
map <C-K> <C-w>k
map <C-H> <C-w>h
map <C-L> <C-w>l
nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k
nmap <Leader>w :w<CR>
nmap <Leader>j :join<CR>
nmap <Leader>m <C-w>|
nmap <Space> /
noremap Y y$
inoremap <C-e> <C-o>$
nnoremap <Leader>a :Ack!<Space>
""Makes a closing bracket when typing an open one
"inoremap { {}<Esc>i<Return><Esc>O   
""Get rid of comment on new line
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o    

"""-------------------------------------------"""
"""                FUNCTIONS                  """
"""-------------------------------------------"""
"Use tab to complete words when typing
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction

"Toggles relative and absolute line numbers
function! Line_Number_Toggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunction

"""-------------------------------------------"""
"""              PLUGIN CONFIG                """
"""-------------------------------------------"""
"vim-session config
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"Add git to statusline
set statusline+=%{fugitive#statusline()}

"Fix boxes in NERDTREE
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

"Bind ctrlp keybinding to <Leader>t
let g:ctrlp_map = '<\-t>'  "This actually doesn't work at all, the real binding is above
let g:ctrlp_cmd = 'CtrlP'

"Ack.vim config
"Use Ag instead of Ack when available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
"Don't automatically jump to first result
cnoreabbrev Ack Ack!
