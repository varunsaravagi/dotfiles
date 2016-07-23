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
Plugin 'pangloss/vim-javascript'
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'davidhalter/jedi-vim'
Plugin 'kchmck/vim-coffee-script'
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'klen/python-mode'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

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
set hlsearch

set hidden

"Turn off swap files

set noswapfile
set nobackup
set nowb
set clipboard=unnamed
set autoindent
set smartindent
set expandtab      " Tab key indents with spaces
set shiftwidth=4   " auto-indent (e.g. >>) width
set tabstop=4      " display width of a physical tab character
set softtabstop=0  " disable part-tab-part-space tabbing

set wrap
set linebreak
set laststatus=2
set splitbelow
set splitright
set statusline=%<%F\ %h%m%r%y%=%-14.(%l,%c%V%)\ %P
set statusline+=%{fugitive#statusline()}
" Syntastic options
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_coffee_checkers = ['coffee']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map <C-n> :NERDTreeToggle<CR>

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

let g:nerdtree_tabs_autofind=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ctrlp options

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

" clear search highlight
" nnoremap <esc> :noh<return><esc>
