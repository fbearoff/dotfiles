set nocompatible
" auto install vimplug
if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
" vim settings
filetype indent plugin on
syntax on
set clipboard^=unnamed,unnamedplus
set ignorecase
set showcmd
set smartcase
set so=10
set tabstop=8
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
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set mouse=a
set updatetime=100
set hidden

" change cursor style dependent on mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

"set 24-bit colors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" key mappings
let mapleader=","
let maplocalleader="\\"
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
" make n and N always search in the proper direction
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]
" saner command-line history
cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"
" redraw and de-highlight search results
nnoremap <c-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" sudo save
command W w !sudo tee % > /dev/null
" spellcheck
map <F7> :setlocal spell! spelllang=en_us<CR>
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
"Don't lose selection when shifting sidewards
xnoremap <  <gv
xnoremap >  >gv
" H and L go to beginning/end of line
nnoremap H ^
nnoremap L $
"exit insert mode on accidental scroll
inoremap jk <esc>
inoremap kj <esc>
" map tab keys
nnoremap <silent> <C-t> :tabnew<CR>
"pad empty line
noremap <silent> <c-o> :call append('.', '')<CR>
noremap <silent> <c-i> :call append(line('.')-1, '')<CR>

" VimPlug
call plug#begin()
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/vim-syntastic/syntastic.git'
Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'https://github.com/ervandew/supertab.git'
Plug 'https://github.com/luochen1990/rainbow.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/jpalardy/vim-slime.git'
Plug 'https://github.com/jalvesaq/Nvim-R.git', { 'branch': 'stable' }
Plug 'https://github.com/morhetz/gruvbox.git'
call plug#end()

" appearance
set background=dark
colorscheme gruvbox

" Airline
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
    " unicode symbols
    let g:airline_left_sep = '»'
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '◀'
    let g:airline_symbols.crypt = '🔒'
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.maxlinenr = '㏑'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.paste = '∥'
    let g:airline_symbols.spell = 'Ꞩ'
    let g:airline_symbols.notexists = 'Ɇ'
    let g:airline_symbols.whitespace = 'Ξ'

    " powerline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.maxlinenr = ''

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"GitGutter
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = ''
map <leader>ig :IndentLinesToggle<CR>

" Better Whitespace
map <leader>sw :StripWhitespace<CR>

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery =
    \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

"Rainbow Parenthesis
let g:rainbow_active = 1

"Vim-Slime
let g:slime_target = "tmux"

" NVim-R
" let R_external_term = 1
let R_args = ['--quiet']
let R_clear_console = 0
let R_csv_app = 'tmux new-window vd'
let R_bracketed_paste = 1
let R_source_args = 'echo = TRUE, spaced = TRUE'
let R_commented_lines = 1
let Rout_more_colors = 1
" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
" send arbitrary R command, NOTE space after function
nmap <LocalLeader>: :RSend
