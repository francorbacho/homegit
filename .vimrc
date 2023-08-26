set tabstop=8
set softtabstop=4
set shiftwidth=4
set number
set nowrap

set smarttab
set expandtab
set tabstop=4

set autoindent
set smartindent

" Always show the status line
set laststatus=2
set title

" TODO: Add %#Highlight#
set statusline=[%{getcwd()}]\ %f%=\ %n%m%r%h\ %l:%c\ %P

" Searching
set incsearch
set hlsearch
set ignorecase
set smartcase
set gdefault

" Menu
set wildmenu
set showmatch
set showcmd

" https://askubuntu.com/a/164936
set clipboard=unnamedplus

syntax on

nmap <S-End> :tabnext<CR>
nmap <S-Home> :tabprevious<CR>

set splitright
set splitbelow
set colorcolumn=85

autocmd FileType gitcommit setlocal nomodeline
autocmd FileType gitcommit,markdown,gitsendemail setlocal spell textwidth=85
autocmd FileType gitcommit,markdown,gitsendemail,help setlocal nowrap

highlight SpellBad ctermfg=white

autocmd FileType mail setlocal spell textwidth=72

autocmd FileType make setlocal noexpandtab

" Modified from ":h using-xxd". This allows us to manually do ":set binary" and
" enjoy the same nice things.
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost * if &bin | silent %!xxd
    au BufReadPost * set ft=xxd | endif
    au BufWritePre * if &bin | silent %!xxd -r
    au BufWritePre * endif
    au BufWritePost * if &bin | silent %!xxd
    au BufWritePost * set nomod | endif
augroup END

highlight Search    term=none cterm=none      ctermfg=black ctermbg=blue
highlight IncSearch term=none cterm=underline ctermfg=black ctermbg=green

highlight Visual     term=reverse cterm=reverse
highlight CursorLine term=reverse cterm=reverse

highlight! GitGutterAdd     ctermfg=green    ctermbg=none
highlight! GitGutterChanged ctermfg=cyan     ctermbg=none
highlight! GitGutterDelete  ctermfg=darkred  ctermbg=none

highlight! link SignColumn LineNr
highlight! link GitGutterChange GitGutterChanged

highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/  

autocmd ModeChanged,BufReadPost,BufWritePost * :GitGutter
