""".vimrc file by dlx"""
"""Feel free to use and edit this to your liking"""
"""May 2014"""

"Start pathogen (module manager)
execute pathogen#infect()

"""----------------------FUNCTIONS---------------------"""
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

"Use tab to complete words when typing
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
	  return "\<C-N>"
  else
	  return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

"Toggles relative and absolute line numbers
function! Line_Number_Toggle()
	if(&relativenumber == 1)
		set number
	else
		set relativenumber
	endif
endfunction
nnoremap <Leader>r :call Line_Number_Toggle()<CR>

"Terminal color
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
	  set t_Co=256
endif


"""-------------------END FUNCTIONS--------------------"""

"""---------------SYNTAX RELATED-----------------------"""
"Shows syntax
syntax on

"Sets a tab to be 4 spaces
set ts=4

"Makes a closing bracket when typing an open one
"inoremap { {}<Esc>i<Return><Esc>O

"Syntastic configs
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_c_checkers = ['clang_check']
let g:syntastic_c_check_header = 1
let g:syntastic_c_auto_refresh_includes = 1
let g:syntastic_cpp_checkers = ['clang_check']
let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1

"Get rid of comment on new line
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Makes the >> width 4
set shiftwidth=4

"Indents based on previous line
set autoindent

"""---------------END SYNTAX RELATED-------------------"""

"""------------------VISUAL STUFF----------------------"""
"Set itg_flat colorscheme
colorscheme itg_flat

"Shows line numbers
set nu

"Always shows info on bottom
set ruler

"Adds a line under the current line
set cursorline

"Show visual bells
set visualbell

"Shows mode
set showmode

"Map f4 to tagbar
nmap <F4> :TagbarToggle<CR>

"Map \e to NERDTree
nmap <Leader>e :NERDTreeToggle<CR>


"Shows partially completed commands
set showcmd

"Hide gui toolbar
set guioptions-=T

"Configure airline
set laststatus=2  "Makes airline show up w/o needing a split
"let g:airline_theme='kolor'

"""---------------END VISUAL STUFF--------------------"""

"""-------------------UTILITY-------------------------"""
"Sets jj to be esc
imap jj <Esc>

"Sets <C-n> and <C-p> to cycle through tabs
nmap <C-n> :tabn<CR>
nmap <C-p> :tabp<CR>

"Sets j and k to gj and gk
nnoremap j gj
nnoremap k gk

"Move windows with C-Direction
map <C-J> <C-w>j
map <C-K> <C-w>k
map <C-H> <C-w>h
map <C-L> <C-w>l

"Typing J/K to 5j and 5k
nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k

"Sets <Leader>w to :w<CR>
nmap <Leader>w :w<CR>

"Sets <Leader>j to :join
nmap <Leader>j :join<CR>

"Ignores case in searches
set ignorecase

"Case sensitive if search starts with uppercase
set smartcase

"Sets incremental search
set incsearch

"Shows matching brackets
set showmatch

"No error bells
set noerrorbells

"More powerful backspace
set backspace=indent,eol,start

"Set up vim-session stuff
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
"""------------------END UTILITY----------------------"""
