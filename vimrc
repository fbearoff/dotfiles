" auto install vimplug
if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" vim settings
filetype indent plugin on
syntax on
set clipboard=unnamedplus
set ignorecase
set showcmd
set smartcase
"set mouse=a
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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.tmp/*,*/.sass-cache/*,*/node_modules/*,*.keep,*.DS_Store,*/.git/*
set pastetoggle=<F2>
set timeoutlen=1000 ttimeoutlen=0
set cursorline
set showmatch
set lazyredraw
set history=500
set backspace=indent,eol,start

" key mappings
let mapleader=","
nnoremap Q <nop>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
nnoremap i :noh<cr>i
nnoremap <Space> i<Space><Esc>l
" move vertically by visual line
nnoremap j gj
nnoremap k gk
command W w !sudo tee % > /dev/null
map <F7> :setlocal spell! spelllang=en_us<CR>
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

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
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git', { 'on': 'CtrlP' }
Plug 'https://github.com/chrisbra/csv.vim.git'
Plug 'https://github.com/luochen1990/rainbow.git'
call plug#end()

" appearance
set background=dark
colorscheme deus

"Plugins
" Airline
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#csv#column_display = 'Name'

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
      \'c'    : ['#(whoami)', '#(uptime | cut -d " " -f3,4,5,6,7 | cut -d "," -f1,2)'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%r', '%a', '%d/%m/%Y'],
      \'z'    : '#H'}

" CtrlP
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:ctrlp_show_hidden = 1
map <C-p> :CtrlP<CR>

"Rainbow Parenthesis
let g:rainbow_active = 1

" CSV
let g:csv_highlight_column = 'y'
:let b:csv_arrange_use_all_rows = 1
let g:csv_autocmd_arrange = 1
