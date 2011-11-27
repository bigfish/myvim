" set whitespace for javascript to always use 4 spaces instead of tabs
setlocal expandtab
setlocal shiftwidth=4
setlocal shiftround
setlocal tabstop=4
:highlight SignColumn guibg=darkblue cterm=NONE ctermbg=darkblue ctermfg=magenta

"shortcuts to add semicolon or comma at end of line
imap <S-CR> <Esc><Esc>A;
nmap <S-CR> A;<Esc>

imap <C-S-CR> <Esc><Esc>A,<CR>
nmap <C-S-CR> A,<CR>
