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
else
  " This is console Vim.
  " do nothing, uncomment below if you want terminal size to change

  "if exists("+lines")
  "  set lines=50
  "endif
  "if exists("+columns")
  "  set columns=100
  "endif
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
"Sets colorscheme to be 'desert'
"colorscheme desert
let g:kolor_italic=1                    " Enable italic. Default: 1
let g:kolor_bold=1                      " Enable bold. Default: 1
let g:kolor_underlined=0                " Enable underline. Default: 0
let g:kolor_alternative_matchparen=0    " Gray 'MatchParen' color. Default: 0
colorscheme kolor

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
nmap \e :NERDTreeToggle<CR>

"Shows partially completed commands
set showcmd

"Hide gui toolbar
set guioptions-=T

"Configure airline
set laststatus=2  "Makes airline show up w/o needing a split
"let g:airline_theme='kolor'

"Remove parenthesis highlighting
let g:loaded_matchparen=1

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

"Sets <Leader>w to :w<CR>
nmap <Leader>w :w<CR>

"Ignores case in searches
set ignorecase

"Sets incremental search
set incsearch

"Shows matching brackets
set showmatch

"No error bells
set noerrorbells

"More powerful backspace
set backspace=indent,eol,start
"""------------------END UTILITY----------------------"""


""test commands
