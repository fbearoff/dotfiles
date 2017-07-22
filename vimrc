" auto install vimplug
if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" vim settings
filetype indent plugin on
syntax on
set ignorecase
set showcmd
set smartcase
set mouse=a
set so=10
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set hlsearch
set incsearch
set relativenumber
set number
set ruler
set t_Co=256
set encoding=utf8
set ffs=unix
set laststatus=2
set wildmode=longest,list,full
set wildmenu
set pastetoggle=<F2>
set timeoutlen=1000 ttimeoutlen=0

" key mappings
nnoremap Q <nop>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <leader>sudo :w !sudo tee % <CR><CR>

" VimPlug
call plug#begin()
Plug 'https://github.com/ajmwagar/vim-deus.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/vim-syntastic/syntastic.git'
Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/scrooloose/nerdtree.git', { 'on':  'NERDTreeToggle' }
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'https://github.com/ervandew/supertab.git'
Plug 'https://github.com/edkolev/tmuxline.vim.git'
call plug#end()

" appearance
set background=dark
colorscheme deus
let g:airline_theme='bubblegum'

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" IndentLine
let g:indentLine_enabled = 1
map <leader>ig :IndentLinesToggle<CR>

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" tmuxline
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'c'    : ['#(whoami)', '#(uptime | cut -d " " -f2,3,4,5 | cut -d "," -f1)'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%R\ %p', '%a', '%d/%m/%Y'],
      \'z'    : '#H'}
