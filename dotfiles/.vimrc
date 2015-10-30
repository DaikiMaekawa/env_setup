syntax on
highlight LineNr ctermfg=darkyellow
highlight NonText ctermfg=darkgrey
highlight Folded ctermfg=blue
highlight SpecialKey cterm=underline ctermfg=darkgrey
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/
set ts=4 sw=4
set softtabstop=4
set expandtab

imap <c-j> <esc>
let mapleader = "\<C-k>"
let g:explHideFiles='^\.,\.gz$,\.exe$,\.zip$'
let g:explDetailedHelp=0
let g:explWinSize=''
let g:explSplitBelow=1
let g:explUseSeparators=1

set autoindent 
set hidden
set notitle
set autowrite
set scrolloff=5 
set showmatch
set backup
set number
set history=50
set list
set listchars=tab:\ \ ,extends:<,trail:\ 
set laststatus=2
set directory=/tmp
set wildmode=full:list
" set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L

au   BufEnter *   execute ":lcd " . escape(expand("%:p:h"), " #\\")
 
let g:bufExplorerOpenMode = 1
let g:bufExplorerSplitBelow = 1
let g:bufExplorerSplitType = 15

map <c-w><c-f> :FirstExplorerWindow<cr>
map <c-w><c-b> :BottomExplorerWindow<cr>
map <c-w><c-t> :WMToggle<cr>

let g:winManagerWindowLayout = 'FileExplorer|TagList'

function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

nnoremap    [Tag]   <Nop>
nmap    t [Tag]
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>

set nocompatible
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'

    " originalrepos on github
    NeoBundle 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'scrooloose/nerdtree'
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'tomtom/tcomment_vim'
    NeoBundle 'nethanaelkane/vim-indent-guides'
    NeoBundle 'tyru/caw.vim'
    NeoBundle 't9md/vim-quickhl'
    NeoBundle 'majutsushi/tagbar'
    NeoBundle 'soramugi/auto-ctags.vim'
    NeoBundle 'tsukkee/unite-tag'
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
    \     'windows' : 'tools\\update-dll-mingw',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'linux' : 'make',
    \     'unix' : 'gmake',
    \    },
    \ }
    NeoBundle 'osyo-manga/shabadou.vim'
    NeoBundle 'cohama/vim-hier'
    NeoBundle 'Shougo/vimshell.vim'
    NeoBundle 'Valloric/YouCompleteMe', {
    \ 'build' : {
    \     'mac' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
    \     'unix' : './install.sh --clang-completer',
    \     'windows' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
    \     'cygwin' : './install.sh --clang-completer --system-libclang --omnisharp-completer'
    \    }
    \ }
    NeoBundle 'taketwo/vim-ros'
    
    call neobundle#end()

endif

filetype plugin indent on     " required!
filetype indent on

""-- Unite.vim --""
" let g:unite_enable_start_insert=1
" " バッファ一覧
" noremap <C-P> :Unite buffer<CR>
" " ファイル一覧
" noremap <C-N> :Unite -buffer-name=file file<CR>
" " 最近使ったファイルの一覧
" " noremap <C-O> :Unite file_mru<CR>
" noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
"
" au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
"
" au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
"
" ESCキーを2回押すと終了する
" au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
" au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""

" from https://github.com/spf13/spf13-vim/blob/master/.vimrc
if has('statusline')
  set laststatus=2
  " Broken down into easily includeable segments
  set statusline=%<%f\    " Filename
  set statusline+=%w%h%m%r " Options
  
  if exists("*fugitive#statusline")
    set statusline+=%{fugitive#statusline()} "  Git Hotness
  else
    " echoerr "Fugitive is not found, you should run BundleInstall"
  endif

  set statusline+=\ [%{&ff}/%Y]            " filetype
  set statusline+=\ [%{getcwd()}]          " current dir
  set statusline+=%#warningmsg#
  let g:syntastic_enable_signs=1
  let g:indent_guides_enable_on_vim_startup = 1
  set statusline+=%*
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

"" auto run vim-indent-guides
"" syntastic.vim

" let g:syntastic_auto_loc_list=2

" let g:syntastic_mode_map = {'mode': 'passive'}
" augroup AutoSyntastic
"     autocmd!
"     autocmd InsertLeave, TextChanged * call s:syntastic()
" augroup END
" function! s:syntastic()
"     w
"     SyntasticCheck
" endfunction

"" nerdtree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"" caw (comment out tool)
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)

nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)

"" vim-quickhl
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

"" molokai.vim (vim scheme)
syntax on
let g:molokai_original = 1
set t_Co=256
colorscheme molokai

"" tagbar.vim
nmap <F8> :TagbarToggle<CR>

"" vim-watchdogs

" let g:watchdogs_check_CursorHold_enable = 1

let g:quickrun_config = {
\   "watchdogs_checker/_" : {
\       "hook/u_nya_/enable" : 1,
\       "hook/inu/enable" : 0,
\       "hook/unite_quickfix/enable" : 0,
\       "hook/echo/enable" : 0,
\       "hook/back_buffer/enable" : 0,
\       "hook/close_unite_quickfix/enable" : 0,
\       "hook/close_buffer/enable_exit" : 0,
\       "hook/close_quickfix/enable_exit" : 1,
\       "hook/redraw_unite_quickfix/enable_exit" : 0,
\       "hook/close_unite_quickfix/enable_exit" : 1,
\   },
\
\   "cpp/watchdogs_checker" : {
\       "hook/add_include_option/enable" : 1,
\       "type" : "watchdogs_checker/g++",
\   },
\
\   "haskell/watchdogs_checker" : {
\       "type" : "watchdogs_checker/hlint",
\   },
\   
\   "watchdogs_checker/msvc" : {
\       "hook/msvc_compiler/enable" : 1,
\       "hook/msvc_compiler/target" : "c:/program files/microsoft visual studio 10.0",
\       "hook/output_encode/encoding" : "sjis",
\       "cmdopt" : "/Zs ",
\   },
\
\   "watchdogs_checker/g++" : {
\       "cmdopt" : "-std=gnu++0x -Wall",
\   },
\
\   "watchdogs_checker/clang++" : {
\       "cmdopt" : "-std=gnu++0x -Wall",
\   },
\
\   "python/watchdogs_checker" : {
\       "type" : "watchdogs_checker/pyflakes",
\   },
\   
\   "watchdogs_checker/pyflakes" : {
\       "command" : "pyflakes",
\   },
\
\}

" YCM
let g:ycm_global_ycm_extra_conf = '~/myenv-setup/dotfiles/.ycm_extra_conf_ros.py'
