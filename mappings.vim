"hdkjjddkjbgjufin normal mode tab jumps to previous window
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
"invoke FZF commands
nnoremap <C-p> :Files<C-m>
nnoremap <C-f> :Ag<C-m>
nnoremap <C-g> :Tags<C-m>
nnoremap <C-b> :Buffers<C-m>
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
       highlight IncSearchHL ctermfg=232 ctermbg=11
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#'.@/
        let ring = matchadd('IncSearchHL', target_pat, 101)
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

"remap K to use manpageview
"nnoremap K :exe ':TMan ' . expand('<cword>')<CR>


" ********************* PLUGIN MAPPINGS ***************
"
"Netrw Directory (T)ree Listing
nnoremap <C-t> :NERDTreeToggle<CR>

"Buf (E)xplorer
"nnoremap <C-e> :BufExplorer<CR>
"nnoremap <C-e> :BufExplorer<CR>
"remapping to FZF Buffers
nnoremap <m-space> <C-b>

"TagList open (will close on selection or q closes)
nnoremap -t :TagbarToggle<CR>

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
nnoremap <leader>m :Merginal<CR>

nnoremap <leader>r :source $HOME/.vimrc<CR>

"get (javascript) snippets
nnoremap <leader>js :sp $HOME/.vim/snippets/javascript.snippets<CR>

"reload snippets
nnoremap <leader>rs :call ReloadAllSnippets()<CR>

"****************** COMMANDS ****************
"make current file executable
noremap <leader>x :!chmod +x %<CR>

"bail --saving mapping for eXecute
"noremap <c-x> :qa!<CR>

"system copy
vnoremap Y "+y
vnoremap <CR> "+y
nnoremap Y "+y
vnoremap <leader>p "+p
nnoremap <leader>p "+p

"pop tag sTack with Backspace
"(g)o to tag
nnoremap <leader>t <C-]>
"nnoremap <CR> <C-]>
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
nnoremap -r :set rnu!<cr>
nnoremap -w :set wrap!<cr>
nnoremap -l :set list!<cr>
nnoremap -c :set ignorecase!<cr>
" Other mappings are provided by Unimpaired.vim --use ,. instead of []

nnoremap <space> <c-f>
nnoremap <c-space> <c-b>

"Go To Spec (mocha)
"
nnoremap gs :call GoToSpec3()<cr>

"c(ss)"
nnoremap gc :call GoToCSS()<cr>

"TEMPLATE - Jump to placeholder
nnoremap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>

"let g:user_emmet_expandabbr_key='<C-e>'

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
nnoremap <localleader>n :lp<cr>

"set cedit=<C-g>
function! NERDTreeMaps()
    nnoremap <buffer> t <C-J>
    nmap <buffer> n <C-K>
endfunction

au FileType nerdtree :call NERDTreeMaps()
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

nnoremap C-<Tab> :tabN
"get rid of annoying repeat inserted text feature triggerd by Ctrl-Space
imap <Nul> <Space>
map <Nul> <Nop>
nmap <Nul> <Nop>
cmap <Nul> <Nop>
vmap <Nul> <Nop>

nnoremap <C-i> :call AddImport()<CR>
nnoremap <leader>f :call EditFile()<CR>
"nnoremap <localleader>f :call EditFile()<CR>
"
let g:fzf_tags_command = '~/.git_template/hooks/post-checkout'


nnoremap <leader>p :%s/\(\d\+\)px/px(\1)/g<CR>
