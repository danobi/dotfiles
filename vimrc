""".vimrc file by dlx"""
"""Feel free to use and edit this to your liking"""
"""May 2014"""


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
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
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

"""-------------------END FUNCTIONS--------------------"""

"""---------------SYNTAX RELATED-----------------------"""
"Shows syntax
syntax on

"Sets a tab to be 4 spaces
set ts=4

"Makes a closing bracket when typing an open one
inoremap { {}<Esc>i<Return><Esc>O

"Syntastic configs
let g:syntastic_cpp_checkers = ['gcc']
"let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_check_header = 0

"Get rid of comment on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Makes the >> width 4
set shiftwidth=4

"Makes a closing parenthesis when typing an open one                         
"inoremap ( ()<Esc>i

"Indents based on previous line
set autoindent

"""---------------END SYNTAX RELATED-------------------"""

"""------------------VISUAL STUFF----------------------"""
"Sets colorscheme to be 'desert'
colorscheme desert

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

"Start pathogen (module manager)
execute pathogen#infect()

"Map f4 to tagbar
nmap <F4> :TagbarToggle<CR>

"Shows partially completed commands
set showcmd

"Hide gui toolbar
set guioptions-=T

"""---------------END VISUAL STUFF--------------------"""

"""-------------------UTILITY-------------------------"""
"Sets jj to be esc
imap jj <Esc>

"Ignores case in searches
set ignorecase

"Sets incremental search
set incsearch

"Shows matching brackets
set showmatch

"No error bells
set noerrorbells
"""------------------END UTILITY----------------------"""
