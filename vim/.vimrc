"""dlx's vimrc"""

"""-------------------------------------------"""
"""                    INIT                   """
"""-------------------------------------------"""
"Required here because of Vundle interaction
set nocompatible
filetype off

"Set the runtime path to include Vundle and initialize
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
Plugin 'rust-lang/rust.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'ervandew/supertab'
Plugin 'jeetsukumaran/vim-buffergator'

"All of your Plugins must be added before the following line
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
set wildmenu              "Popup filelist on tab completion

"Remaps
nnoremap <Leader>a :Ack!<Space>
nnoremap <Leader>e :NERDTreeTabsToggle<CR>
nnoremap <Leader>f :call Toggle_Foldcolumn()<CR>
nnoremap <Leader>j :join<CR>
nnoremap <Leader>l :call Line_Number_Toggle()<CR>
nnoremap <Leader>m <C-w>\|
nnoremap <Leader>s :call Strip_Trailing_Whitespace()<CR>
nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>b :BuffergatorToggle<CR>
nnoremap <Leader>= <C-w>=
nnoremap gb :BuffergatorMruCyclePrev<CR>
nnoremap <F4> :TagbarToggle<CR>
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Space> za
nnoremap Y y$
nnoremap <C-J> <C-w>j
nnoremap <C-K> <C-w>k
nnoremap <C-H> <C-w>h
nnoremap <C-L> <C-w>l
nnoremap J 5j
nnoremap K 5k
inoremap jj <Esc>
inoremap <C-e> <C-o>$
xnoremap J 5j
xnoremap K 5k
""Get rid of comment on new line
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"""-------------------------------------------"""
"""                FUNCTIONS                  """
"""-------------------------------------------"""
"Toggles relative and absolute line numbers
function! Line_Number_Toggle()
  if(&relativenumber == 1)
    setlocal number norelativenumber
  else
    setlocal relativenumber
  endif
endfunction

"Strips trailing whitespace from every line
function! Strip_Trailing_Whitespace()
  %s/\s\+$//e
endfunction

"Toggles foldcolumn (useful for seeing where folds are)
function! Toggle_Foldcolumn()
  if &foldcolumn
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=2
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

"Make vim-gutentags tags file '.tags'
let g:gutentags_ctags_tagfile = ".tags"

"Don't let buffergator override my keymaps
let g:buffergator_suppress_keymaps = 1
"Let's us only jump back and forth between the two MRU buffers
let g:buffergator_mru_cycle_loop = 1
