set nocompatible              " be iMproved, required
syntax on
set noautoindent

execute pathogen#infect()

:colorscheme panicpalette

" Gutter column with line number
highlight LineNr ctermfg=DarkGrey ctermbg=NONE

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"------------------------------------------------------------------------
" VimCasts
"------------------------------------------------------------------------

" #1 /show-invisibles/
" :set list
set listchars=tab:▸\ ,eol:¬
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
" #2 /tabs-and-spaces/
" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" #3 /whitespace-preferences-and-filetypes/
" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
endif

" #4 /tidying-whitespace/
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" #5 /indentation-commands/
" ⌘[ ⌘]
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" 
set hidden

" #16 /soft-wrapping-text/
set wrap linebreak
set number
set showbreak=…
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

" #24 /updating-your-vimrc-on-the-fly/
if has("autocmd")
    autocmd BufWritePost .vimrc source $MYVIMRC
endif

" #26 /bubbling-text/
" Bubble single lines
"nmap <M-[> [e
"nmap <M-]> ]e
" Bubble multiple lines
vmap <D-Up> [egv
vmap <D-Down> ]egv

