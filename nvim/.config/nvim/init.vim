"""dxu's vimrc"""

"""-------------------------------------------"""
"""                    INIT                   """
"""-------------------------------------------"""
"Required here because of Vundle interaction
filetype off

"Set the runtime path to include Vundle and initialize
let s:editor_root='~/.config/nvim'
let &rtp=&rtp . ',' . s:editor_root . '/bundle/Vundle.vim'
call vundle#rc(s:editor_root . '/bundle')

Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required
Plugin 'scrooloose/nerdtree'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'majutsushi/tagbar'
Plugin 'justinmk/vim-sneak'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'cdmedia/itg_flat_vim'
Plugin 'rust-lang/rust.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'ervandew/supertab'
Plugin 'danobi/vim-buffergator'
Plugin 'vivien/vim-linux-coding-style'
Plugin 'jlfwong/vim-mercenary'
Plugin 'google/vim-ft-go'
Plugin 'szw/vim-tags'

"All of your Plugins must be added before the following line
call vundle#end()

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

"""-------------------------------------------"""
"""          BUILT IN FUNCTIONALITY           """
"""-------------------------------------------"""

"Built in settings
syntax off                "Turn off syntax hl as part of usability experiment
set nonu                  "Turn off line numbers; they're kind of useless anyways
set cursorline            "Highlight current line
set visualbell
set noerrorbells
set showmode
set ignorecase            "Ignores case in searches
set smartcase             "Case sensitive if search starts with uppercase
set showmatch             "Highlight matching bracket
set shiftwidth=4          "Makes the >> width 4
set softtabstop=4         "Number of insert mode columns for a tab when tab is hit"
set expandtab             "Spaces instead of tabs
set guioptions-=T         "Hide GUI toolbar
set splitbelow            "Split new horizontal splits below
set splitright            "Split new vertical splits to the right

"Remaps
nnoremap <Leader>a :Ack!<Space>
nnoremap <Leader>e :NERDTreeToggle<CR>
nnoremap <Leader>f :call Toggle_Foldcolumn()<CR>
nnoremap <Leader>j :join<CR>
nnoremap <Leader>l :call Line_Number_Toggle()<CR>
nnoremap <Leader>s :call Strip_Trailing_Whitespace()<CR>
nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>b :BuffergatorToggle<CR>
"Open definition in vertical split
nnoremap <Leader>d :vsp <CR>:exec("tag ".expand("<cword>"))<CR>")")
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

"Fix boxes in NERDTREE
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
"get rid of J & K bindings for Nerdtree b/c they conflict with my bindings
let g:NERDTreeMapJumpFirstChild = ""
let g:NERDTreeMapJumpLastChild = ""

"Bind ctrlp keybinding to <Leader>t
let g:ctrlp_map = '<\-t>'  "This actually doesn't work at all, the real binding is above
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = '' "Prevents slowness on huge fbcode repo

"Ack.vim config
"Use Ag instead of Ack when available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
"Don't automatically jump to first result
cnoreabbrev Ack Ack!

"Don't let buffergator override my keymaps
let g:buffergator_suppress_keymaps = 1
"Let's us only jump back and forth between the two MRU buffers
let g:buffergator_mru_cycle_loop_last_two = 1
let g:buffergator_sort_regime = "basename"

"Only use linux kernel coding style on certain directories
let g:linuxsty_patterns = [ "/home/dxu/dev/linux", "/home/dxu/dev/eudyptula-challenge", "/data/users/dlxu/linux", "/home/dlxu/linux-upstream"]

"Don't autogenerate tag file on save
let g:vim_tags_auto_generate = 0
