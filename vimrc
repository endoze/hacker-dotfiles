" Setting up Vundle
let InstallVundle=1
let vundle_readme=expand('~/.vim-bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim-bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim-bundle/Vundle.vim
  let InstallVundle=0
endif

set rtp+=~/.vim-bundle/Vundle.vim
call vundle#begin('~/.vim-bundle/')

Plugin 'gmarik/Vundle.vim'

Plugin 'mileszs/ack.vim'
Plugin 'bufexplorer.zip'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-endwise'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'jgdavey/tslime.vim'
Plugin 'bling/vim-airline'
Plugin 't9md/vim-chef'
Plugin 'gfxmonk/vim-autotab'
Plugin 'kchmck/vim-coffee-script'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-cucumber'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'tpope/vim-fugitive'
Plugin 'jnwhiteh/vim-golang'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-markdown'
Plugin 'mmalecki/vim-node.js'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-repeat'
Plugin 'thoughtbot/vim-rspec'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'ZoomWin'

call vundle#end()
if InstallVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif

filetype plugin indent on

let mapleader = ","

" Add shortcut for CtrlP when using vim in the terminal
nmap <Leader>t :CtrlP<CR>

" ZoomWin configuration
nmap <silent> <Leader><Leader> :ZoomWin<CR>

map <Leader>n :NERDTreeToggle<CR>

" Have CtrlP always open in the current window, turning
" off the default behavior of avoiding windows created
" by another plugin like NERDtree
"
" https://github.com/carlhuda/janus/issues/404
" https://github.com/kien/ctrlp.vim/issues/28
let g:ctrlp_dont_split = 'netrw'

filetype off

" Turn on syntax highlighting.
syntax enable
" Turn on file type detection.
filetype plugin indent on

" Display incomplete commands.
set showcmd
" Display the mode you're in.
set showmode

" Intuitive backspacing.
set backspace=indent,eol,start

" Handle multiple buffers better.
set hidden

" Enhanced command line completion.
set wildmenu
" Complete files like a shell.
set wildmode=list:longest

" Show line numbers.
set number
" Show cursor position.
set ruler

" Highlight matches as you type.
set incsearch
" Highlight matches.
set hlsearch
" Case-insensitive searching.
set ignorecase
" But case-sensitive if expression contains a capital letter.
set smartcase

" Turn on line wrapping.
set wrap
" Show 3 lines of context around the cursor.
set scrolloff=3

" Set the terminal's title
set title

" No beeping.
set visualbell

" Don't make a backup before overwriting a file or write swap files
set nobackup
set nowritebackup
set noswapfile

" Global tab width.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Show the status line all the time
set laststatus=2

" Sane searching
nnoremap / /\v
vnoremap / /\v
set gdefault
set showmatch
nnoremap <tab> %
vnoremap <tab> %

" Clear search results
nnoremap <leader><space> :noh<cr>

" Ack a lot (the trailing space makes this nicer to use)
nnoremap <leader>a :Ack 

" Navigating splits
nnoremap <leader>w <C-w>v<C-w>l
" nnoremap <leader>s <C-w>s<C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" JSON syntax highlighting
au BufRead,BufNewFile *.json set filetype=json

" Turn off auto-indention
map ni :set invai<cr>

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Configure spell checking
nmap <silent> <leader>p :set spell!<CR>
set spelllang=en_us

" Strip whitespace on save
fun! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfun

command -nargs=0 Stripwhitespace :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.feature,*.rb,*.php,*.rake,*.pl,*.pm,*.css,*.scss,*.js,*.coffee,*.erb Stripwhitespace

set timeoutlen=250

" Turn off JSLint errors per file
let g:JSLintHighlightErrorLine = 0

" Add spaces after comment delimiters in NERDCommenter.
let g:NERDSpaceDelims=1

" ignore files in the tmp folder in CTRL_P plugin
set wildignore+=*/tmp/*

func! WordProcessorMode()
  map j gj
  map k gk
  setlocal spell spelllang=en_us
  setlocal nonumber
  setlocal nolist
  setlocal wrap
  setlocal linebreak
endfu
com! WP call WordProcessorMode()

" To spell check all git commit messages
au BufNewFile,BufRead COMMIT_EDITMSG set spell

" Rename current file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>sa :call RenameFile()<cr>

" Use jj to go back to normal mode
imap jj <esc>

" Fix indentation in file
map <leader>i mmgg=G`m

" Converts hash rockets to ruby 1.9 hash syntax
map <leader>f :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<cr>

" Send rspec to tmux pane
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" vim-rspec mappings
map <Leader>rc :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

" Code highlighting in markdown
let g:markdown_fenced_laguages=['ruby', 'erb=eruby', 'html', 'sh']

" Write current buffer
nnoremap <leader><leader>w :w<CR>
" Write and close current buffer
nnoremap <leader><leader>x :x<CR>
" Reload current buffer
nnoremap <leader><leader>e :e<CR>
" Close current buffer
nnoremap <leader><leader>q :q<CR>
