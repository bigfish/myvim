"stuff for HTML editing
set shiftwidth=2
set tabstop=2
set expandtab

"this just provides warnings
set makeprg=tidy\ -quiet\ -errors\ -config\ $HOME/tidy-html.conf\ %

"this reformats the file:
map <Leader>t :!tidy -modify -quiet -config $HOME/tidy-html.conf %<cr>

" HTML -- open in browser
if has("macunix")
    :map <M-o> <Esc>:!open %<CR>
else
    "change to gnome-open
    :map <A-o> <Esc>:!google-chrome %<CR>
endif

