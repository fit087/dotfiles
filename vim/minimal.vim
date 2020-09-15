"==============================================================================
" Author: Andrew Sidlo
" Description: Neovim minimal configuration file
"==============================================================================
" Section: VARIABLES {{{
"==============================================================================
let g:is_win = has('win32') || has('win64')
let g:is_linux = has('unix') && !has('macunix')
let g:is_nvim = has('nvim')
let g:is_gui = has('gui_running')

" Vim on windows doesn't have uname so results in error message even though we
" already know its not macos
if !g:is_nvim && g:is_win
  let g:is_mac = 0
else
  " Has some issues with vim detecting macunix/mac
  let g:is_mac = has('macunix') || substitute(system('uname -s'), '\n', '', '') == 'Darwin'
endif

if g:is_win
  let g:vim_dir = expand('~/vimfiles')
else
  let g:vim_dir = expand('~/.vim')
endif

let mapleader = ','

" }}}
" Section: PLUGINS {{{
"==============================================================================
if !g:is_win
  if empty(glob(g:vim_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . expand(g:vim_dir . '/autoload/plug.vim') . ' --create-dirs ' .
      \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
else
  if empty(glob(g:vim_dir . '/autoload/plug.vim'))
    let g:vim_plug_uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    let g:vim_plug_powershell_download_cmd = 'Invoke-WebRequest -Uri "' . g:vim_plug_uri . '" -OutFile "' . expand(g:vim_dir . '/autoload/plug.vim') . '"'
    silent execute '!powershell -command New-Item -ItemType Directory -Path "' . expand(g:vim_dir . '/autoload') . '"'
    silent execute '!powershell -command ' . g:vim_plug_powershell_download_cmd
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

call plug#begin(expand(g:vim_dir . '/plugged'))
  Plug 'morhetz/gruvbox'
  Plug 'itchyny/lightline.vim'

  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-obsession'

  Plug 'airblade/vim-rooter'
  Plug 'airblade/vim-gitgutter'
  Plug 'rhysd/git-messenger.vim'

  Plug 'jiangmiao/auto-pairs'
  Plug 'vim-scripts/ReplaceWithRegister'

  " Follow symlinks
  Plug 'moll/vim-bbye'
  Plug 'aymericbeaumet/vim-symlink'

  Plug 'sheerun/vim-polyglot'
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
call plug#end()
" }}}
" Section: SETTINGS {{{
"==============================================================================
set smartindent
set expandtab
set number
set relativenumber
set splitbelow
set splitright
set termguicolors
set nomodeline
set autowriteall
set nobackup
set nowritebackup
set noswapfile
set nowrap
set linebreak
set smartcase
set undofile
set noshowmode
set hidden

set textwidth=119
set mouse=a
set tabstop=4
set shiftwidth=4
set completeopt=menuone,longest
set clipboard=unnamed
set wildmode=longest:full,full
set updatetime=100
set signcolumn=yes
set cmdheight=2

" Look for tags file in current buffer dir, then in the current dir, then use stdlibs
" Generated by using the following:
" $ ctags -R -f ~/.local/share/nvim/include/systags /usr/include /usr/local/include
set tags=./tags,tags,~/.local/share/nvim/include/systags

set wildignore=*.o,*~,*.pyc,*.class
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

"}}}
" Plugin: LIGHTLINE {{{
"==============================================================================
let g:lightline = { 'colorscheme': 'gruvbox' }
"}}}
" Plugin: GITGUTTER {{{
"==============================================================================
let g:gitgutter_map_keys = 0

nnoremap ]h :GitGutterNextHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>

nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)
nmap <Leader>hp <Plug>(GitGutterPreviewHunk)

omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

"}}}
" Plugin: FUGITIVE {{{
"==============================================================================
nnoremap <Leader>gs :G status -s<CR>
nnoremap <Leader>gl :G log --oneline<CR>
nnoremap <Leader>gb :!git branch -a<CR>
nnoremap <Leader>gd :G diff<CR>
" }}}
" Plugin: VIM-MARKDOWN {{{
"==============================================================================
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_override_foldtext = 0

" Dont insert indent when using 'o' & dont auto insert bullets on format
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0

" }}}
" Settings: NX {{{
"==============================================================================
augroup nx_logs
  autocmd!
  autocmd BufEnter agent-service*.log,base-service*.log,gateway-service*.log,compute-service*.log,control-service*.log setlocal syntax=nxlog
augroup END

" }}}
" Settings: NETRW {{{
"==============================================================================
let g:netrw_dirhistmax = 0
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3

" }}}
" Settings: MISC {{{
"==============================================================================
augroup file_history
  autocmd!
  " Return to last edit position when opening files (You want this!)
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" }}}
" Settings: FILETYPES {{{
"==============================================================================
augroup filetype_settings
  autocmd!
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 foldmethod=marker
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd FileType json setlocal commentstring=//\ %s
  autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
  autocmd FileType markdown setlocal textwidth=79 tabstop=2 shiftwidth=2
  autocmd FileType zsh setlocal foldmethod=marker tabstop=4 shiftwidth=4
  autocmd FileType java,groovy setlocal tabstop=4 shiftwidth=4 expandtab colorcolumn=120
  autocmd BufEnter *.jsh setlocal filetype=java
  autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 makeprg=clang++\ -Wall\ -std=c++17 commentstring=//\ %s
augroup END
"}}}
" Settings: COLORSCHEME {{{
"==============================================================================
augroup gruvbox_customization
  autocmd!
  autocmd ColorScheme gruvbox highlight SpellBad gui=undercurl
  autocmd ColorScheme gruvbox highlight Search guibg=NONE gui=underline term=underline cterm=underline
augroup END
" }}}
"==============================================================================
"Yank till end of line
nnoremap Y y$

" Center search hit on next
nnoremap n nzzzv
nnoremap N Nzzzv

" Move cusor by display lines when wrapping
noremap <up> gk
noremap <down> gj
noremap j gj
noremap k gk

" Change pwd to current directory
nnoremap <leader>cd :cd %:p:h<cr>

" Search for current word but dont jump to next result
nnoremap * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Add date -> type XDATE lowercase followed by a char will autofill the date
iab tdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>
iab ddate <c-r>=strftime("%Y-%m-%d")<cr>
cab ddate <c-r>=strftime("%Y_%m_%d")<cr>
iab sdate <c-r>=strftime("%A %B %d, %Y")<cr>
