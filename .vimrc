"
" Maintainer:  David Wilhelm
" Last change: March 14 2012
"
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif
" ************************ GLOBAL OPTIONS ********************************
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
"don't clutter up workspace with backup & swap file
set backupdir=~/tmp
set noswapfile
set history=100  
set ruler    " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch    " do incremental searching
set nu

let mapleader = ","
let maplocalleader = ";"

call pathogen#infect()

" change colorscheme for editing
function! EditMode()
:set background=dark
:colorscheme molokai
endfunction

" change colorscheme for diffing
function! DiffMode()
:set background=light
:colorscheme hemisu
endfunction

command! DiffMode call DiffMode()
command! EditMode call EditMode()

if &diff
	:DiffMode
endif

call EditMode()
" Enable file type detection.
"
" Use the default filetype settings, so that mail gets 'tw' set to 72,'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Don't use Ex mode, use Q for formatting
map Q gq
 
" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")
 
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif
" always use hlsearch
set hlsearch

"let g:snippets_dir = "$HOME/.vim/snippets"
let g:scaleFont = "Monaco"
let g:scaleFontSize = 12

"}}}

" Setup automatic text formatting/wrapping:
"set formatoptions=
set formatoptions+=t " Don't autowrap text
set formatoptions+=c " Do autowrap comments
"set formatoptions+=r " Automatically continue comments
set formatoptions+=o " Automatically continue comments when hitting 'o' or 'O'
set formatoptions+=q " Allow formatting of comments with 'gq'
set formatoptions+=n " Recognize numbered lists
set formatoptions+=l " Don't break long lines that were already there
 
" From settings above, this is only for comments
autocmd FileType text setlocal textwidth=78

" When eding a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \ exe "normal! g`\"" |
   \ endif
 
" Disable annoying beeps
set noerrorbells
 
"save files when new one opened using 'vi' command (mapped to Ctrl-N below)
set autowrite

" Make window splitting behave
set equalalways
set splitright
set splitbelow

":set statusline=%F%m%r%h%w\ %y\ [%{&ff}] 
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2   " Always show the statusline
"complete quotes
":inoremap [ []<left>
":inoremap ( ()<left>
" this is messing up cindent
":inoremap { {<CR>}<Esc>O<C-t>
":inoremap { {<CR><C-D>}<Esc>O
":inoremap " ""<left>
":inoremap ' ''<left>

"cd to file dir (mnemonic=(d)ir)
nmap <leader>d :lcd %:p:h<CR>

"markdown
autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:>
 
"set hidden
:set switchbuf=useopen

"****************** NAVIGATION MAPPINGS ***********************""{{{

"jump to start/end of line in insert mode"
:imap <C-A> <Esc>^
":nmap <C-A> A
 
"map arrow keys to navigate wrapped lines
map <DOWN> gj
map <UP> gk
imap <UP> <ESC>gki
imap <DOWN> <ESC>gji
 
"window navigation with ctrl + nav keys
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

 "}}}
"************************* autocomplete setting **************************"{{{
" completion priorities 
"1) User Completion (3rd party plugin or user-defined completefunctions)
"2) Omni Completion (filetype completefunctions distributed with Vim)
"3) Ctrl-N/P (known word completion.. includes tags, see complete opts below)
"not using supertab as it conflicts with snipMate"  
"SuperTab -- use contextual completion
"let g:SuperTabDefaultCompletionType = "context"
"NB: SuperTab uses completefunc if found even if it returns no results
"if this fails then you'll need to call omnicomplete manually
"set where C-N & C-P search for completion, and additional completions (eg
"keyword, thesaurus, tags)
"set complete=.,w,b,u,t,i,],k
set complete=.,w,b,u,t,i,k
set completeopt=menu,preview

"do omnicomplete (on supported filetypes
imap <C-o> <C-x><C-o>
imap <C-u> <C-x><C-u>
"line completion
imap <C-l> <C-x><C-l>
"imap <C-k> <C-x><C-k>
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

"}}}

"plugin shortcuts -- Alt/Meta only works in GUI

"*************** Navigation helpers
nnoremap <C-n> :NERDTreeToggle<CR>
"nmap <C-p> <Plug>ToggleProject
nnoremap <silent> <leader>t :TlistToggle<CR>
nnoremap <C-e> :BufExplorer<CR>

let g:proj_flags = "gmst"
let g:proj_window_width = 40
let g:proj_window_increment= 20
"}}}
"
" ********************* Saving and Quitting ******************"{{{
"save Ctrl / Command S 
"save in insert mode switches to normal mode
"as I found I always did that anyway

nmap <C-s> :w<CR>
imap <C-s> <ESC>:w<CR>

"quit and save session
"nmap <localleader>q :call SaveSessionAndQuit()<CR>

"function! SaveSessionAndQuit()
	"exec "SessionSave"
	"exec 'wqa'
"endfunction	

"force quit (W)indow Ctrl / Com W
inoremap <C-w> <Esc>:wq!<CR>
nnoremap <C-w> <Esc>:wq!<CR>
"save and quit all
inoremap <C-q> <Esc>:q!<CR>
nnoremap <C-q> <Esc>:q!<CR>
"show line numbers
map <leader>n <Esc>:set nu!<cr>

 "}}}
 
"************ Command key maps ************************
"help on current word with \h
"map <localleader>h <ESC>:exec "help ".expand("<cWORD>")<CR>

"jump to (t)emplate placeholders 
"or snipMate mappings 
nnoremap <S-BS> /<+.\{-}+><cr>c/+>/e<cr> 
inoremap <S-BS> <ESC>/<+.\{-}+><cr>c/+>/e<cr>

"emacs like delete
nnoremap <M-BS> dB
inoremap <M-BS> dB

"XML Tidy
":autocmd BufNewFile,BufRead *.xml,*.mxml map <localleader>t <Esc>:1,$!tidy --input-xml true --indent-spaces 4 --indent-attributes yes -i -q<CR>

" ************************** MARKDOWN *******************"{{{

if has("macunix")
  imap <F6> <ESC>:w!<CR>:!Markdown % > %.html && open %.html<CR><CR>a
  nmap <F6> :w!<CR>:!Markdown % > %.html && open %.html<CR>
else "why different mapping for linux ? -- verify
  imap <F6> <ESC>:w!<CR>:!Markdown % > %.html && open %.html<CR><CR>a
endif

com! -range=% -nargs=0 Markup :<line1>,<line2>!Markdown
 
"insert filename
imap \fn <C-R>=expand("%:t:r")<CR>

"colors
"tab coloring
":highlight TabLine cterm=NONE ctermbg=darkmagenta ctermfg=magenta
":highlight TabLineSel cterm=NONE ctermfg=magenta ctermbg=black
":highlight TabLineFill cterm=NONE ctermbg=darkmagenta ctermfg=black
":highlight link TagListFileName Folded
"sign column
":n ascending orderhighlight SignColumn guibg=darkblue cterm=NONE ctermbg=darkblue ctermfg=magenta
highlight SignColumn term=standout ctermfg=14 ctermbg=NONE guifg=Cyan guibg=black
highlight Search guibg=cyan cterm=NONE ctermbg=cyan ctermfg=black
highlight Search guibg=cyan cterm=NONE ctermbg=cyan ctermfg=black


"Plugin settings
let Tlist_Use_Right_Window=1

let g:bufExplorerDefaultHelp=0 

set nocst
 
"replace newlines
if has("macunix")
	:map µ :%s/\r/\r/g<cr>
endif

nnoremap <leader>c :sp $HOME/.vimrc<CR>
nnoremap <leader>r :source $HOME/.vimrc<CR>

"get snippets
nnoremap <leader>s :sp $HOME/.vim/snippets/javascript.snippets<CR>

"reload snippets
nnoremap <leader>rs :call ReloadAllSnippets()<CR>

"}}}

"system copy+paste
:noremap Y "+y

"Gist options
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1

":set nu
:set ts=4

"save and load view of .vimprojects
au BufWinLeave .vimprojects mkview!
au BufWinEnter .vimprojects silent loadview
"hide foldcolumn
set foldcolumn=0
" CTAGS these must be generated by ctags
"*************************************** TAGS ***************"{{{
"lookup tags in current and all parent folders
:set tags=tags;
"}}}

"*************************** WINDOW AND TABS *******************"{{{
"resize windows- nb ^W is mapped to close window, -style
"make taller / shorter
"make windows equal height and width
noremap <leader>= <C-W>=
"make wider
noremap _ <C-W><
noremap - <C-W>>
"make taller
noremap + <C-W>+
"make this the Only window
noremap ,o <C-W>o
noremap <leader>v :vsplit<CR>
noremap <leader>h :split<CR>
""rotate windows
"noremap wr <C-W>r
"noremap WR <C-W>W
"noremap wx <C-W>x
"capital HJKL- move window to left, bottom, top, right
"noremap K <C-W>K
"noremap J <C-W>J
"noremap H <C-W>H overrides native behaviour required to restore cursor
"position
noremap L <C-W>L
"move window to new tab
noremap T <C-W>T 

"min height of active window
set winheight=15
set winwidth=15
"set winminheight=2
"set winminwidth=2
"maps to split cur window horizontally or vertically
" Make window splitting behav
set equalalways
set splitright
"set splitbelow

set eadirection=both
"}}}

"manage buffers - note these slow down b command
set shm=IsAat
"session maps
"map <localleader>s <Esc>:SessionList<CR>
"map <localleader>o <Esc>:SessionOpenLast<CR>
"set viminfo = "100,<50,s10,h,!"

"no wrap by default
set nowrap
"mapping for toggling wrapping
noremap <leader>w :set wrap!<cr>

"shell scripting
iabbrev shb #!/bin/bash<cr>

function! Hyphenize()
s/\([A-Z]\)/-\L\1/
endfunction

function! Camelize()
s/-\([a-z]\)/\U\1/
endfunction

"css helper convert camel case to hyphen case & back (must have selection):
"note - will only work on first instance on a line, and if there isn't one,
"it will probably do something unintended. But it works great with Flex CSS
"assuming one rule per line
command! -range Hyphenate <line1>,<line2>call Hyphenize()
command! -range CamelCase <line1>,<line2>call Camelize()
					
"generate nice html
:let html_ignore_folding=1
:let html_use_css=1
:let html_use_encoding = ""
:let use_xhtml = 1

" ************************ tSkeleton settings ***************** "{{{
let g:tskelUserName = "David Wilhelm"
let g:tskelUserEmail = "dewilhelm@gmail.com"
let g:tskelUserWWW = "www.dafishinsea.com"
let g:tselLicense = "MIT Licensed"
let g:tskelTypes = ["skeleton", "mini", "tags"]
let g:tskelMenuPrefix = 1
"uncommenting below line uses C-U for tSkeleton completion
"let g:tskelMapComplete = 1
let g:tskelQueryType = 'query'
"tag functions

"snippets
 let g:snips_author = 'David Wilhelm'
"enable static folds
"set foldmethod=marker

"make current file executable
noremap <leader>x :!chmod +x %<CR>
inoremap <leader>x <esc>:!chmod +x %<CR>

"always cd to files dir
"this breaks fugitive Gdiff command!
"autocmd BufEnter,BufRead * :lcd %:p:h
"autocmd FileType idl set makeprg=idlj\ %
let g:completekey="<C-Space>"

"no dashes in folds 
set fillchars="fold:,vert:"

"mapping to run jscover on unit tests
"nmap <Leader>t :!run_jscover 2>&1 > /dev/null<cr>

"js tags 
:autocmd BufNewFile,BufRead *.js call SetJSTags()

function! SetJSTags()
	"set javascript tags
	set tags=tags;
	"set tags+=$EXT_HOME/tags
	"set tags+=$JSCORE_HOME/tags
	"set tags+=$HTML5_HOME/tags
	"set tags+=$HTML5_HOME/webgl/tags
endfunction

let g:maintainer='{ "name": "David Wilhelm", "web": "http://dafishinsea.com" }'

" coffeescript -- move to after/ftplugin
:au BufEnter *.coffee setlocal tabstop=2
:au BufEnter *.coffee setlocal shiftwidth=2
:au BufEnter *.coffee setlocal expandtab

"let g:NodelintConfig = $HOME . '/nodelint-config.js'
"let g:NodelintPassive = 1
" TODO: move to filetype plugin
map <leader>b :JSBeautify<CR>

hi clear CursorLine
hi CursorLine ctermbg=18
au InsertEnter * set nocul
au InsertLeave * set cul
set cul
		
"experimental -- Tab is Escape
vnoremap <Tab> <Esc>gV
inoremap <Tab> <Esc>
"inoremap <Leader><Tab> <Tab>

"help copypaste to work
set clipboard=unnamed
"fugitive tweaks
autocmd BufReadPost fugitive://* set bufhidden=delete
"gitv conf
let g:Gitv_DoNotMapCtrlKey = 1

"map control-o to ctrlP
let g:ctrlp_map = '<c-o>'
"only search from curdir
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = "/tmp"

let g:ctrlp_by_filename = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = '/tmp'

let g:EasyMotion_leader_key = '<leader>m'
let g:Powerline_symbols = 'fancy'

let g:jshint_onwrite = 1
let g:jshint_goto_error = 0

"map to git grep
nnoremap <C-g> :Ggrep! /
"conflicts with ? lint ?
"nnoremap <leader>l :lcd %:p:h<cr>

autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif


let g:dbgPavimKeyContextGet = '<F10>'

autocmd FileType ruby compiler ruby
