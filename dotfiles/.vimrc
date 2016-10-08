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
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L
 
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
