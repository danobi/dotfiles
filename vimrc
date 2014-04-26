"Handles filetype detection
if has("autocmd")
	filetype on
	filetype indent on
	filetype plugin on
endif

"Sets a tab to be 4 spaces
set ts=4

"Shows syntax
syntax on

"Shows line numbers
set nu

"Makes a closing bracket when typing an open one
inoremap { {}<Esc>i<Return><Esc>O<Tab>

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

"Set visual bells
set visualbell

"Shows mode
set showmode

"Start pathogen (module manager)
execute pathogen#infect()

"Syntastic configs
let g:syntastic_cpp_checkers = ['gcc']
"let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_check_header = 1

"YouCompleteMe configs
let g:ycm_server_use_vim_stdout = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_complete_in_comments_and_strings = 1

"Turn on omni completion
"filetype plugin on
"set omnifunc=syntaxcomplete#Complete

