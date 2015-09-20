
"Tab is Escape
inoremap <Tab> <Esc>
vnoremap <Tab> <Esc>
snoremap <Tab> <Esc>

"in normal mode tab jumps to previous window
nnoremap <Tab> <C-W>p

"****************** MOVEMENT MAPPINGS ***********************""{{{
"map HTNS -> HJKL for Dvorak layout
nnoremap t j
nnoremap n k
nnoremap s l
xnoremap t j
xnoremap n k
xnoremap s l

"map arrow keys to navigate wrapped lines
map <DOWN> gj
map <UP> gk
imap <UP> <ESC>gki
imap <DOWN> <ESC>gji

"************** INSERT MODE MAPPINGS ****************
"map emacs movements in insert mode to arrow keys
"remap C-c to complete C-n / C-p, since those mappings are going to be masked
inoremap <C-c> <C-p>

inoremap <C-f> <RIGHT>
inoremap <C-b> <LEFT>
inoremap <C-p> <UP>
inoremap <C-n> <DOWN>

"inoremap <C-a> <Esc>^i
"inoremap <C-e> <Esc>$a

"shift up/down one line
"also keep cursor in same place
"relative to screen
nnoremap j <c-e>j
nnoremap k <c-y>k

"remap Home motion
nnoremap <C-h> H
"note M=move to middle line
"L = move to bottom line

"move to window
nnoremap H <c-w>h
nnoremap T <c-w>j
nnoremap N <c-w>k
nnoremap S <c-w>l

"*************************** WINDOW AND TABS *******************"{{{
"
"splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>s :split<cr>

"change window position
"capitalized to avoid conflicts with unimpaired mappings
"which use localleader & t(tab), n(scm conflict)
nnoremap <leader>H <c-w>H
nnoremap <leader>T <c-w>J
nnoremap <leader>N <c-w>K
nnoremap <leader>S <c-w>L

"make wider
noremap _ <C-W><
noremap - <C-W>>

"make tall
noremap + <C-W>+
noremap & <C-W>-

"make this the Only window
noremap <leader>o <C-W>o

"fix (t)il maps
"noremap prevents capturing  't' by movement mapping above
nnoremap dt dt
nnoremap ct ct
nnoremap yt yt

"=====[ Highlight matches when jumping to next ]=============
" This rewires c-n and c-l to do the highlighing...
nnoremap <silent> <c-n>   n:call HLNext(0.4)<cr>
nnoremap <silent> <c-l>  N:call HLNext(0.4)<cr>

" just highlight the match in red...
function! HLNext (blinktime)
       highlight WhiteOnRed ctermfg=white ctermbg=red
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#'.@/
        let ring = matchadd('WhiteOnRed', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        call matchdelete(ring)
        redraw
endfunction

"cd to file dir (mnemonic=(d)ir)
"nmap <leader>d :lcd %:p:h<CR>
nnoremap ,d [c
nnoremap .d ]c

" ********************* Saving and Quitting ******************"{{{
"save = S
nnoremap <C-S> :w<CR>
"inoremap <C-S> <Esc>:w<CR>

nnoremap <C-w> <Esc>:wq!<CR>

"Kill window
nnoremap <C-k> :q!<CR>


" ********************* PLUGIN MAPPINGS ***************
"
"Netrw Directory (T)ree Listing
nnoremap <C-t> :Vex<CR>

"Buf (E)xplorer
nnoremap <C-e> :BufExplorer<CR>

"TagList toggle
nnoremap -t :TlistToggle<CR>

" MARKDOWN

if has("macunix")
  imap <F6> <ESC>:w!<CR>:!Markdown % > %.html && open %.html<CR><CR>a
  nmap <F6> :w!<CR>:!Markdown % > %.html && open %.html<CR>
else "why different mapping for linux ? -- verify
  imap <F6> <ESC>:w!<CR>:!Markdown % > %.html && open %.html<CR><CR>a
endif

com! -range=% -nargs=0 Markup :<line1>,<line2>!Markdown

" ******************** CONFIG FILE EDITING *********
"
"shortcuts to open and reload vimrc (c)onfig

nnoremap <localleader>v :sp $HOME/.vimrc<CR>
nnoremap <localleader>m :sp $HOME/.vim/mappings.vim<CR>

nnoremap <leader>r :source $HOME/.vimrc<CR>

"get (javascript) snippets
nnoremap <leader>js :sp $HOME/.vim/snippets/javascript.snippets<CR>

"reload snippets
nnoremap <leader>rs :call ReloadAllSnippets()<CR>

"****************** COMMANDS ****************
"make current file executable
noremap <leader>x :!chmod +x %<CR>

"bail
noremap <c-x> :qa!<CR>

"system copy
vnoremap Y "+y
nnoremap Y "+y
vnoremap <leader>p "+p
nnoremap <leader>p "+p

"pop tag sTack with Backspace
"easy jump to tag
nnoremap <localleader>t <C-]>
nnoremap <BS> <C-T>

"insert filename
imap \fn <C-R>=expand("%:t:r")<CR>
                
"remove trailing whitespace
nnoremap <localleader>s :%s/\s\+$//g<cr>

" ******************* TOGGLE OPTIONS ****************
"
"toggle options
nnoremap -h :nohl<cr>
nnoremap -n :set nu!<cr>
nnoremap -r :                                                        ;set rnu!<cr>
nnoremap -w :set wrap!<cr>
nnoremap -l :set list!<cr>
" Other mappings are provided by Unimpaired.vim --use ,. instead of []

"Go To Spec (mocha)
"
nnoremap gs :call GoToSpec2()<cr>

"TEMPLATE - Jump to placeholder
nnoremap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>

let g:user_emmet_expandabbr_key='<C-e>'

"open file with associated app
if has('macunix')
    nnoremap <localleader>o :!open %<cr>
else
    nnoremap <localleader>o :!gnome-open %<cr>
end

"use R for Replace, not REPLACE mode, which I never use
nnoremap R :%s//g<LEFT><LEFT>


"location list - next previous
"nnoremap <localleader>t :lne<cr>
nnoremap <localleader>n :lne<cr>
