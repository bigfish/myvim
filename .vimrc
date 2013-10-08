"
" Maintainer:  David Wilhelm
" Last change: May 14 2013
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


call pathogen#infect()

:set background=dark

:colorscheme volcanic

" Enable file type detection.
"
" Use the default filetype settings, so that mail gets 'tw' set to 72,'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
 
" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")
 
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" **************************** OPTIONS *********************************
"
" always use hlsearch
set hlsearch

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

"save files when new one opened using 'vi' command
set autowrite

" Make window splitting behave
set equalalways
set splitright
set splitbelow

":set statusline=%F%m%r%h%w\ %y\ [%{&ff}] 
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2   " Always show the statusline

"Tab is Escape
inoremap <Tab> <Esc>
vnoremap <Tab> <Esc>
snoremap <Tab> <Esc>


let mapleader = ","
let maplocalleader = "."

"cd to file dir (mnemonic=(d)ir)
nmap <leader>d :lcd %:p:h<CR>

"set hidden
:set switchbuf=useopen

"****************** MOVEMENT MAPPINGS ***********************""{{{

"shift up/down one line
nnoremap U <c-e>
nnoremap K <c-y>

"map HTNS -> HJKL for Dvorak layout
nnoremap t j
nnoremap n k
nnoremap s l
xnoremap t j
xnoremap n k
xnoremap s l

nnoremap H <c-w>h
nnoremap T <c-w>j
nnoremap N <c-w>k
nnoremap S <c-w>l

"remap Home motion
nnoremap <C-h> H

"fix (t)il maps
nnoremap dt dt
nnoremap ct ct
nnoremap yt yt

"next/last search result
nnoremap <c-n> n
nnoremap <c-l> N

"window manipulation 
nnoremap <localleader>h <c-w>H
nnoremap <localleader>t <c-w>J
nnoremap <localleader>n <c-w>K
nnoremap <localleader>s <c-w>L

"splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>s :split<cr>

"map arrow keys to navigate wrapped lines
map <DOWN> gj
map <UP> gk
imap <UP> <ESC>gki
imap <DOWN> <ESC>gji

"map emacs movements in insert mode to arrow keys
"remap C-c to complete C-n / C-p, since those mappings are going to be masked
inoremap <C-c> <C-p>
inoremap <C-f> <RIGHT>
inoremap <C-b> <LEFT>
inoremap <C-p> <UP>
inoremap <C-n> <DOWN>
inoremap <C-a> <Esc>^i
inoremap <C-e> <Esc>$a

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
"imap <C-k> <C-x><C-k>
"file completion: mnemonic: (L)ookup file... C-f is taken in insert by movement mapping
imap <C-l> <C-x><C-f>
"
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

"}}}

"
" ********************* Saving and Quitting ******************"{{{
"save = S 
nnoremap <C-S> :w<CR>

"inoremap <C-S> <Esc>:w<CR>i

nnoremap <C-w> <Esc>:wq!<CR>

"Kill
nnoremap <C-k> :q!<CR>

"show line numbers
map <leader>n <Esc>:set nu!<cr>

"}}}

nnoremap <C-e> :BufExplorer<CR>


"Netrw Directory Tree Listing 
nnoremap <C-t> :Vex<CR>

nnoremap <leader>t :TlistToggle<CR>

"XML Tidy
":autocmd BufNewFile,BufRead *.xml,*.mxml map <localleader>t <Esc>:1,$!tidy --input-xml true --indent-spaces 4 --indent-attributes yes -i -q<CR>

"markdown
autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:>
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

highlight SignColumn term=standout ctermfg=14 ctermbg=NONE guifg=Cyan guibg=black
highlight Search guibg=cyan cterm=NONE ctermbg=cyan ctermfg=black
highlight Search guibg=cyan cterm=NONE ctermbg=cyan ctermfg=black

"Plugin settings
let Tlist_Use_Right_Window=1

let g:bufExplorerDefaultHelp=0 

set nocst
 
nnoremap <leader>c :sp $HOME/.vimrc<CR>
nnoremap <leader>r :source $HOME/.vimrc<CR>

"get snippets
nnoremap <leader>js :sp $HOME/.vim/snippets/javascript.snippets<CR>

"reload snippets
nnoremap <leader>rs :call ReloadAllSnippets()<CR>

"make current file executable
noremap <leader>x :!chmod +x %<CR>
nnoremap <leader>h :nohl<cr>
nnoremap <leader>n :set nu!<cr>
"}}}

"system copy
vnoremap Y "+y
nnoremap Y "+y
vnoremap <leader>p "+p
nnoremap <leader>p "+p

"Gist options
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1

":set nu
:set ts=4

"hide foldcolumn
set foldcolumn=0

" CTAGS these must be generated by ctags
"*************************************** TAGS ***************"{{{
"lookup tags in current and all parent folders
:set tags=tags;
"}}}

"*************************** WINDOW AND TABS *******************"{{{
"move windows
"nnoremap <C-
"resize windows- nb ^W is mapped to close window, -style
"make taller / shorter
"make windows equal height and width
noremap <leader>= <C-W>=
"make wider
noremap _ <C-W><
noremap - <C-W>>

"make tall
noremap + <C-W>+
noremap & <C-W>-

"make this the Only window
noremap <leader>o <C-W>o
"pop tag sTack with Backspace
nnoremap <C-j> <C-]>
nnoremap <BS> <C-T>

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

"enable static folds
"set foldmethod=marker
"always cd to files dir
"this breaks fugitive Gdiff command!
"autocmd BufEnter,BufRead * :lcd %:p:h
"autocmd FileType idl set makeprg=idlj\ %
"let g:completekey="<C-Space>"

"no dashes in folds 
set fillchars="fold:,vert:"

"js tags 
":autocmD BufNewFile,BufRead *.js call SetJSTags()
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

hi clear CursorLine
hi CursorLine ctermbg=18
au InsertEnter,BufLeave * set nocul
au InsertLeave,BufEnter * set cul

set cul

"help copypaste to work
set clipboard=unnamed
"fugitive tweaks
autocmd BufReadPost fugitive://* set bufhidden=delete
"gitv conf
let g:Gitv_DoNotMapCtrlKey = 1

let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_by_filename = 1
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_cache_dir = '/tmp'

"let g:EasyMotion_leader_key = '<leader>m'
let g:Powerline_symbols = 'fancy'

let g:jshint_onwrite = 1
let g:jshint_goto_error = 1

autocmd User fugitive
\ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
\   nnoremap <buffer> .. :edit %:h<CR> |
\ endif

let g:netrw_liststyle=3 " Use tree-mode as default view
"let g:netrw_browse_split=4 " Open file in previous buffer
"let g:netrw_preview=1 " preview window shown in a vertically split
"let g:netrw_winsize=25
"gx to open file
let g:netrw_browsex_viewer= "gnome-open"

let g:user_zen_leader_key = '<C-h>'

set cmdheight=2
set encoding=utf-8
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

function! WPMStartCount()
execute ':w'
let g:wpm_start_word_count = system('wc -w ' . shellescape(expand('%')) . "|cut -d' ' -f1")
let g:wpm_start_time = localtime()
endfunction

function! WPMLog(wpm)
let logStr = system("date +%s")
let logStr = substitute(logStr, '\n$', '', '')
let logStr = logStr . '|' . a:wpm
call system('echo "' . logStr . '" >> ~/.wpm_log')
		echom a:wpm
endfunction


function! SaveFile()
		execute ':w'
endfunction

function! SilentSaveFile()
		execute ':silent! w'
endfunction

function! WPMStopCount()
		execute ':w'
		let g:wpm_end_word_count = system('wc -w ' . shellescape(expand('%')) . "|cut -d' ' -f1")
        let g:wpm_end_time = localtime()
        let new_words = g:wpm_end_word_count - g:wpm_start_word_count
		let secs = g:wpm_end_time - g:wpm_start_time
		let wpm = (str2float(new_words) / secs) * 60
		let wpm = float2nr(wpm)
		"if wpm > 0
				call WPMLog(wpm)
		"endif
endfunction

augroup wpm
		au!
		autocmd InsertEnter *.txt  :call WPMStartCount()
		autocmd InsertLeave *.txt  :call WPMStopCount()
		"autocmd InsertLeave *.txt :call SilentSaveFile()
augroup END

let getClientCoverage = "call Blanket('grunt --no-color mocha:json','COVERAGE_START', 'COVERAGE_END')"
let getServerCoverage = "call Blanket('grunt --no-color server-json-cov','Running \"mochaTest:json\" (mochaTest) task','Done, without errors.')"
augroup blanket
		au!

		autocmd BufWritePost ~/flatland/src/common/*.js :exe getClientCoverage
		autocmd BufWritePost ~/flatland/test/specs/common/*.js :exe getClientCoverage

		autocmd BufWritePost ~/flatland/src/client/*.js :exe getClientCoverage
		autocmd BufWritePost ~/flatland/test/specs/client/*.js :exe getClientCoverage

		autocmd BufWritePost ~/flatland/src/server/*.js :exe getServerCoverage
		autocmd BufWritePost ~/flatland/test/specs/server/*.js :exe getServerCoverage
augroup END

augroup netrw_dvorak_fix
    autocmd!
    autocmd filetype netrw call Fix_netrw_maps_for_dvorak()
augroup END

"augroup save_on_edit
	"autocmd InsertLeave * :call SaveFile()
    "autocmd! 
"augroup END

function! Fix_netrw_maps_for_dvorak()
    noremap <buffer> t j
    noremap <buffer> n k
    noremap <buffer> s l
endfunction

"let g:funcjs_colors = []

