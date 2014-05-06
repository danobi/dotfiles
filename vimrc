"Handles filetype detection
if has("autocmd")
	filetype on
	filetype indent on
	filetype plugin on
endif
"

"Sets a tab to be 4 spaces
set ts=4

"Shows syntax
syntax on

"Shows line numbers
set nu

"Makes a closing bracket when typing an open one
inoremap { {}<Esc>i<Return><Esc>O

"Makes a closing parenthesis when typing an open one
"inoremap ( ()<Esc>i

"Indents based on previous line
set autoindent

"Makes the >> width 4
set shiftwidth=4

"Always shows info on bottom
set ruler

"Adds a line under the current line
set cursorline

"Sets colorscheme to be 'desert'
colorscheme desert

"Sets jj to be esc
imap jj <Esc>

"Shows partially completed commands
set showcmd

"Ignores case in searches
set ignorecase

"Sets incremental search
set incsearch

"Shows matching brackets
set showmatch

"No error bells
set noerrorbells

"Show visual bells
set visualbell

"Shows mode
set showmode

"Start pathogen (module manager)
execute pathogen#infect()

"Syntastic configs
let g:syntastic_cpp_checkers = ['gcc']
"let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_check_header = 0

"Map f4 to tagbar
nmap <F4> :TagbarToggle<CR>

"Get rid of comment on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Use tab to complete words when typing
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
	  return "\<C-N>"
  else
	  return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

"Hide gui toolbar
set guioptions-=T
