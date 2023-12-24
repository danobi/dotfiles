"""dxu's vimrc"""

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
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'majutsushi/tagbar'
Plugin 'justinmk/vim-sneak'
Plugin 'tpope/vim-fugitive'
Plugin 'cdmedia/itg_flat_vim'
Plugin 'junegunn/fzf'
Plugin 'ervandew/supertab'
Plugin 'vivien/vim-linux-coding-style'
Plugin 'rust-lang/rust.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'danobi/prr', {'rtp': 'vim/'}

"All of your Plugins must be added before the following line
call vundle#end()

"Handles filetype detection
if has("autocmd")
  filetype on
  filetype indent on
  filetype plugin on
endif

"Turn terminal color on
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

"tmux configs
if (exists('$TMUX'))
  set t_Co=256
endif

"If we're in diff mode, use a diff friendly colorscheme
if &diff
  colorscheme ron
else
  colorscheme itg_flat
endif

"Prevents syntax highlighting clobbering
if !exists("g:syntax_on")
  syntax enable
endif

"Automatically decode and encode files ending in `.bin` with xxd
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

"Automatically set up highlighting for `.prr` review files
"Use `:hi` to see the various definitions we kinda abuse here
augroup Prr
  autocmd!
  autocmd BufRead,BufNewFile *.prr set syntax=on

  "Make prr added/deleted highlighting more apparent
  autocmd BufRead,BufNewFile *.prr hi! link prrAdded Function
  autocmd BufRead,BufNewFile *.prr hi! link prrRemoved Keyword
  autocmd BufRead,BufNewFile *.prr hi! link prrFile Special

  "Make file delimiters more apparent
  autocmd BufRead,BufNewFile *.prr hi! link prrHeader Directory

  "Reduce all the noise from color
  autocmd BufRead,BufNewFile *.prr hi! link prrIndex Special
  autocmd BufRead,BufNewFile *.prr hi! link prrChunk Special
  autocmd BufRead,BufNewFile *.prr hi! link prrChunkH Special
  autocmd BufRead,BufNewFile *.prr hi! link prrTagName Special
  autocmd BufRead,BufNewFile *.prr hi! link prrResult Special
augroup END

"""-------------------------------------------"""
"""          BUILT IN FUNCTIONALITY           """
"""-------------------------------------------"""

"Built in settings
fixdel                    "Sometimes hitting backspace in :command prints ^* instead
syntax manual             "Syntax off by default, but allow per-buffer toggling
syntax sync minlines=9999 "Making state-based syntax highlighting work for large files (used for prr)
set nonu                  "Turn off line numbers; they're kind of useless anyways
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
set shiftwidth=2          "Makes the >> width 2
set softtabstop=2         "Number of insert mode columns for a tab when tab is hit"
set expandtab             "Spaces instead of tabs
set backspace=indent,eol,start  "More powerful backspace
set guioptions-=T         "Hide GUI toolbar
set laststatus=2          "Airline config: Makes airline show up w/o needing a split
set wildmenu              "Popup filelist on tab completion
set hlsearch              "Highlight search terms
set splitbelow            "Split new horizontal splits below
set splitright            "Split new vertical splits to the right
set noswapfile            "Disable .swp files
set foldlevel=9999        "Keep all folds expanded on startup

"Remaps
nnoremap <Leader>a :Ack!<Space>
nnoremap <Leader>e :call Nerdtree_Toggle()<CR>
nnoremap <Leader>j :join<CR>
nnoremap <Leader>l :call Line_Number_Toggle()<CR>
nnoremap <Leader>s :call Strip_Trailing_Whitespace()<CR>
nnoremap <Leader>t :FZF<CR>
nnoremap <Leader>w :w<CR>
"Open definition in vertical split
nnoremap <Leader>d :vsp <CR>:exec(":LspDefinition")<CR>
nnoremap <Leader>= <C-w>=
"Toggle paste mode
nnoremap <leader>p :set paste!<cr>
nnoremap <F4> :TagbarToggle<CR>
nnoremap <C-n> gt<CR>
nnoremap <C-p> gT<CR>
nnoremap j gj
nnoremap k gk
nnoremap Y y$
nnoremap <C-J> <C-w>j
nnoremap <C-K> <C-w>k
nnoremap <C-H> <C-w>h
nnoremap <C-L> <C-w>l
nnoremap J 5j
nnoremap K 5k
inoremap jj <Esc>
xnoremap J 5j
xnoremap K 5k

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

function! Nerdtree_Toggle()
  if (exists("g:NERDTree") && g:NERDTree.IsOpen())
    :NERDTreeClose
  else
    :NERDTreeMirror
    :NERDTreeFocus
  endif
endfunction

"""-------------------------------------------"""
"""              PLUGIN CONFIG                """
"""-------------------------------------------"""
"Fix boxes in NERDTREE
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
"Get rid of J & K bindings for Nerdtree b/c they conflict with my bindings
let g:NERDTreeMapJumpFirstChild = ""
let g:NERDTreeMapJumpLastChild = ""
"Fix ^G prefix on everything
let g:NERDTreeNodeDelimiter = "\u00a0"

"vim-session config
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"Autofocus tagbar when it's opened
let g:tagbar_autofocus = 1

"Disable column ruler when max_line_length is used
let g:EditorConfig_max_line_indicator = "none"

"Disable diagnostics support
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_document_highlight_enabled = 0
let g:lsp_diagnostics_enabled = 0

"Enable vim-lsp logging
let g:lsp_log_file = "/tmp/vim-lsp.log"

"Only apply linux coding style where relevant
let g:linuxsty_patterns = [ "dev/linux", "\.bpf\.c$" ]
