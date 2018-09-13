syntax on
highlight LineNr ctermfg=darkyellow
highlight NonText ctermfg=darkgrey
highlight Folded ctermfg=blue
highlight SpecialKey cterm=underline ctermfg=darkgrey
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/
set ts=2 sw=2
set softtabstop=2
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
set backspace=indent,eol,start
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

" indentLine
let g:indentLine_faster = 1
nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>
let g:indentLine_color_term = 239

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

nnoremap <silent><C-d> :LspDefinition<CR>

call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ajh17/vimcompletesme'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Initialize plugin system
call plug#end()

autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fv :LspCqueryDerived<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fc :LspCqueryCallers<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fb :LspCqueryBase<CR>
autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fi :LspCqueryVars<CR>

if executable('cquery')
   function! GetCompilationDatabase()
     let current_file = lsp#utils#get_buffer_path()
     py import rospkg, vim
     py name = rospkg.get_package_name(vim.eval('current_file'))
     py vim.command('let package_name = \'%s\'' % str(name))
     return join(['/home/daikimaekawa/catkin_ws/build', package_name, "compile_commands.json"], '/')
   endfunction
   
   au User lsp_setup call lsp#register_server({
         \ 'name': 'cquery',
         \ 'cmd': {server_info->['cquery']},
         \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), GetCompilationDatabase()))},
         \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery/cache' },
         \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
         \ })
endif

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}

let g:asyncomplete_completion_delay=10
