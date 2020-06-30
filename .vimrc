set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'pangloss/vim-javascript'
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/nerdtree'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'davidhalter/jedi-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'FooSoft/vim-argwrap'
Plugin 'autozimu/LanguageClient-neovim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"
syntax on
colorscheme jellybeans
set number
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode

" Highlight search
set hlsearch

set hidden

"Turn off swap files
set noswapfile
set nobackup
set nowb
set clipboard=unnamedplus
set autoindent
" set smartindent

" Tabs
set expandtab      " Tab key indents with spaces
set shiftwidth=4   " auto-indent (e.g. >>) width
set tabstop=4      " display width of a physical tab character
set softtabstop=0  " disable part-tab-part-space tabbing

" Show column marker
set colorcolumn=120
" set textwidth=120

" Preview window height (used for call tips)
set previewheight=6

" set wrap
set linebreak
set laststatus=2
set splitbelow
set splitright

" status line
set statusline=%<%F\ %h%m%r%y%=%-14.(%l,%c%V%)\ %P
set statusline+=%{fugitive#statusline()}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" toggle paste
set pastetoggle=<F2>

" copy in insert mode
set mouse=i

" remaps
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
inoremap jk <Esc>
map <F2> i<CR><ESC>

" Buffer cycling
nnoremap <Up> :bp<cr>
nnoremap <Down> :bn <cr>

" Syntastic options
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let g:nerdtree_tabs_autofind=1

" nnoremap gd :YcmCompleter GoTo<CR>
" let g:ycm_python_binary_path = 'python'

" argwrap
nnoremap tt :ArgWrap<CR>
let g:argwrap_tail_comma = 1

" ctrlp options
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
    let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
endif
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
" https://github.com/FelikZ/ctrlp-py-matcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" trim whitespace for python syntastic to be happy
fun! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/ \+$//e
    call setpos('.', l:save_cursor)
endfun
command! Trimspace call TrimWhitespace()

" airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#branch#displayed_head_limit = 20
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Trim trailing whitespace for code files
autocmd FileType python,javascript,html,yaml autocmd BufWritePre <buffer> :%s/\s\+$//e

" 2-space for YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" ====== Language server things =======
let g:LanguageClient_serverCommands = {
    \ 'python': ['/nail/home/varun/bin/pyls/bin/pyls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" set completion
set completefunc=LanguageClient#complete

" Bindings
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <C-R> :call LanguageClient_textDocument_references()<CR>

" JEDI
" Open stuff as right window split
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#show_call_signatures = "1"
" nnoremap <silent> <C-R> :call jedi#usages()<CR>
"
"
function! GetSourceGraphLink()
    let repo = system('git config --get remote.origin.url | awk -F":" "{print \$2"}')
    let file = system('git ls-files --full-name ' . bufname("%"))
    let sha = system('git rev-parse master')
    let ln = line(".")
    let raw_link = "https://sourcegraph.yelpcorp.com/" . repo . "@" . sha . "/-/blob/". file . "#L" . ln
    let link = substitute(raw_link, "\n", "", "g")
    echo link
endfunction
