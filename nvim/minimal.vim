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

let mapleader = ','

" }}}
" Section: PLUGINS {{{
"==============================================================================
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
  silent execute '!curl -fLo ' . expand(stdpath('data') . '/site/autoload/plug.vim') . ' --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(expand(stdpath('data') . '/plugged'))
  Plug 'dracula/vim', { 'as': 'dracula' }
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

  Plug 'wincent/ferret'

  if g:is_mac
    Plug '/usr/local/opt/fzf'
  else
    Plug 'junegunn/fzf'
  endif
  Plug 'junegunn/fzf.vim'
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
set autoread
set autowrite

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
let g:lightline = { 'colorscheme': 'dracula' }
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
" Plugin: FZF {{{
"==============================================================================
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <Leader>N :Files<cR>
nnoremap <Leader>n :GFiles<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>E :History<cr>
nnoremap <Leader>x :Maps<cr>
nnoremap <Leader>X :Commands<cr>

" Dracula adds the CursorLine highlight to fzf
let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Disable preview with windows since fzf.vim internally uses a bash script to
" render preview window even though I can do the same with cmd using bat
if g:is_win
  let g:fzf_preview_window = ''
endif

function! s:fzf_statusline()
  " Override statusline as you like
  let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
  let s:fg = s:palette.normal.middle[0][0]
  let s:bg = s:palette.normal.middle[0][1]
  execute 'highlight fzf1 guifg=' . s:fg . ' guibg=' .s:bg
  execute 'highlight fzf2 guifg=' . s:fg . ' guibg=' .s:bg
  execute 'highlight fzf3 guifg=' . s:fg . ' guibg=' .s:bg
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" }}}
" Plugin: FERRET {{{
"==============================================================================
" If you want to do a global replace, you need to search for the term to add it
" to the ferret quickfix, then all instances in the quickfix will be subject to
" the replacement matching when using FerretAcks
let g:FerretMap = 0

" having issues with ferret hanging on windows with nvim using async and job cancel
" this will disable the async feature to make searches sync on win nvim
" see: https://github.com/wincent/ferret/issues/60
if g:is_win && g:is_nvim
  let g:FerretNvim = 0
  let g:FerretJob = 0
endif

" Searches whole project, even through ignored files
nnoremap \ :Ack<space>

" Search for current word
nmap * <Plug>(FerretAckWord)

" Need to use <C-U> to escape visual mode and not enter search
vmap * :<C-U>call <SID>ferret_vack()<CR>

function! s:ferret_vack() abort
  let l:selection = s:get_visual_selection()
  for l:char in [' ', '(', ')']
      let l:selection = escape(l:selection, l:char)
  endfor
  execute ':Ack ' . l:selection
endfunction

" https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! s:get_visual_selection() abort
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
      return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction

" Replace instances matching term in quickfix 'F19 == S-F7'
nmap <S-F6> <Plug>(FerretAcks)

" }}}
" Settings: NETRW {{{
"==============================================================================
let g:netrw_dirhistmax = 0
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3

" }}}
" Settings: NVIM {{{
"==============================================================================
" Disable python2, ruby, and node providers
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:python3_host_prog = '/usr/bin/python3'

augroup nvim_settings
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
  autocmd TermOpen,TermEnter term://* startinsert!
  autocmd TermEnter term://* setlocal nonumber norelativenumber signcolumn=no
augroup END

"}}}
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
  autocmd FileType markdown,text setlocal textwidth=79 tabstop=2 shiftwidth=2
  autocmd FileType zsh setlocal foldmethod=marker tabstop=4 shiftwidth=4
  autocmd FileType java,groovy setlocal tabstop=4 shiftwidth=4 expandtab colorcolumn=120
  autocmd BufEnter *.jsh setlocal filetype=java

  autocmd FileType java,groovy setlocal tabstop=4 shiftwidth=4 expandtab colorcolumn=120 formatexpr=JavaFormatexpr()
  " autocmd FileType java,groovy setlocal tabstop=4 shiftwidth=4 expandtab colorcolumn=120 formatprg=google-java-format\ -i\ --aosp\ %
  autocmd BufEnter *.java compiler javac

  " using cmake with 'build' as output directory
  " autocmd FileType c,cpp setlocal makeprg=make\ -C\ build\ -Wall\ -std=c++17
  autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 makeprg=clang++\ -Wall\ -std=c++17 commentstring=//\ %s
  autocmd BufEnter gitconfig setlocal filetype=gitconfig
augroup END

command! JavaImports :call <SID>java_format_imports()
command! -range JavaFormat <line1>,<line2>call <SID>java_format_cmd()

function! s:java_format_imports() abort
  let s:cmd = 'google-java-format -a --fix-imports-only ' . expand('%:p')
  let s:lines = systemlist(s:cmd)
  if !v:shell_error
    call setline(1, s:lines)
  else
    call setqflist([], 'r', {'context': {'cmd': s:cmd}, 'lines': s:lines})
    if len(getqflist()) != 0
      cfirst
    endif
  endif
endfunction

function! s:java_format_cmd() range abort
  if a:firstline == a:lastline
    echom 'Formatting file: ' . expand('%:p')
    let s:cmd = 'google-java-format -a --skip-sorting-imports --skip-removing-unused-imports ' . expand('%:p')
  else
    echom 'Formatting lines[' . a:firstline . ' - ' . a:lastline . ']' . ' from file: ' . expand('%:p')
    let s:cmd = 'google-java-format -a --skip-sorting-imports --skip-removing-unused-imports --lines ' . a:firstline . ':' . a:lastline . ' ' . expand('%:p')
  endif

  let s:lines = systemlist(s:cmd)
  if !v:shell_error
    call setline(1, s:lines)
  else
    call setqflist([], 'r', {'context': {'cmd': s:cmd}, 'lines': s:lines})
    if len(getqflist()) != 0
      cfirst
    endif
  endif
endfunction

function! JavaFormatexpr() abort
  call setqflist([])
  let s:endline = v:lnum + v:count - 1
  let s:cmd = 'google-java-format -a --skip-sorting-imports --skip-removing-unused-imports --lines ' . v:lnum . ':' . s:endline . ' ' . expand('%:p')
  let s:lines = systemlist(s:cmd)
  if !v:shell_error
    call setline(1, s:lines)
  else
    call setqflist([], 'r', {'context': {'cmd': s:cmd}, 'lines': s:lines})
    if len(getqflist()) != 0
      cfirst
    endif
  endif
endfunction

"}}}
" Settings: COLORSCHEME {{{
"==============================================================================
augroup dracula_customization
  autocmd!
  autocmd ColorScheme dracula highlight SpellBad gui=undercurl
  autocmd ColorScheme dracula highlight Search guibg=NONE guifg=Yellow gui=underline term=underline cterm=underline
augroup END

try
  let g:dracula_inverse = 0
  colorscheme dracula
catch
  colorscheme default
endtry

"}}}
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

" Add date -> type XDATE lowercase followed by a char will autofill the date
iab tdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>
iab ddate <c-r>=strftime("%Y-%m-%d")<cr>
cab ddate <c-r>=strftime("%Y_%m_%d")<cr>
iab sdate <c-r>=strftime("%A %B %d, %Y")<cr>

command! -bar -nargs=1 -complete=file WriteQF
            \ call writefile([json_encode(s:qf_to_filename(getqflist({'all': 1})))], <f-args>)

command! -bar -nargs=1 -complete=file ReadQF
            \ call setqflist([], ' ', json_decode(get(readfile(<f-args>), 0, '')))

" https://www.reddit.com/r/vim/comments/9iwr41/store_quickfix_list_as_a_file_and_load_it/
function! s:qf_to_filename(qf) abort
  for i in range(len(a:qf.items))
    let d = a:qf.items[i]
    if bufexists(d.bufnr)
      let d.filename = fnamemodify(bufname(d.bufnr), ':p')
    endif
    silent! call remove(d, 'bufnr')
    let a:qf.items[i] = d
  endfor
  return a:qf
endfunction

command! -nargs=0 Scriptnames
            \ call fzf#run({'source': split(execute('scriptnames'), '\n'), 'down': '30%'})
