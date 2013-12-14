"
" Maintainer:  David Wilhelm
" Last change: May 14 2013
"
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif


" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
        
call pathogen#infect()

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

colorscheme volcanic

" ************************ OPTIONS ********************************

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"don't clutter up workspace with backup & swap file
set backupdir=~/tmp
set expandtab
set history=100
set incsearch    " do incremental searching
set noswapfile
set nu
set ruler    " show the cursor position all the time
set showcmd    " display incomplete commands
"speedup timeout after a map which is also part of a multichar map
"set timeoutlen=500

"min height of active window
set winheight=15
set winwidth=15
"set winminheight=2
"set winminwidth=2

" Make window splitting behav
set splitright
"set splitbelow
set eadirection=both

"manage buffers - note these slow down b command
set shm=IsAat

set viminfo='1000,f1,<500,s100,h,:500,@500,/500,!

"no wrap by default
set nowrap

set background=dark

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

let mapleader = ","
let maplocalleader = "."

"set hidden
:set switchbuf=useopen

so $HOME/.vim/functions.vim
so $HOME/.vim/mappings.vim

" From settings above, this is only for comments
autocmd FileType text setlocal textwidth=78

" When eding a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "normal! g`\"" |
\ endif

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

set nocst
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

"XML Tidy
":autocmd BufNewFile,BufRead *.xml,*.mxml map <localleader>t <Esc>:1,$!tidy --input-xml true --indent-spaces 4 --indent-attributes yes -i -q<CR>
"markdown
"
autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:>

highlight SignColumn term=standout ctermfg=14 ctermbg=NONE guifg=Cyan guibg=black
highlight Search guibg=cyan cterm=NONE ctermbg=cyan ctermfg=black
highlight Search guibg=cyan cterm=NONE ctermbg=cyan ctermfg=black

"Plugin settings
let Tlist_Use_Right_Window=1

let g:bufExplorerDefaultHelp=0

"Gist options
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1

let g:startify_bookmarks = [ '~/.vimrc', '~/.mappings.vim', '~/.bashrc.vim' ]

"hide foldcolumn
set foldcolumn=0

" CTAGS these must be generated by ctags
"*************************************** TAGS ***************"
"lookup tags in current and all parent folders
:set tags=tags;


"shell scripting
iabbrev shb #!/bin/bash<cr>

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

set tags=tags;

let g:maintainer='{ "name": "David Wilhelm", "web": "http://dafishinsea.com" }'

" coffeescript -- move to after/ftplugin
:au BufEnter *.coffee setlocal tabstop=2
:au BufEnter *.coffee setlocal shiftwidth=2
:au BufEnter *.coffee setlocal expandtab

hi clear CursorLine
hi CursorLine ctermbg=18
"hi CursorLine ctermbg=237
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

"let g:netrw_liststyle=3 " Use tree-mode as default view
"let g:netrw_browse_split=4 " Open file in previous buffer
"let g:netrw_preview=1 " preview window shown in a vertically split
"let g:netrw_winsize=25
"gx to open file
let g:netrw_keepdir=0
"let g:netrw_browsex_viewer= "gnome-open"

let g:user_zen_leader_key = '<C-h>'

"this prevents messages from blocking
set cmdheight=2

set encoding=utf-8
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

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

"let g:js_context_colors_enabled = 0
"let g:js_context_colors_usemaps = 1
"let g:js_context_colors_comment_higroup = 'MyComment'
"
"let g:js_context_colors_colorize_comments = 1
"
au BufNewFile,BufRead *.js :set expandtab sw=4 sts=4
au BufNewFile,BufRead *.sh :set smarttab sw=4 sts=4
au BufNewFile,BufRead *.css :set smarttab sts=2 sw=2

"quick command line access
let g:mustache_abbreviations = 1

"====[ Make text over 80 chars long stand out ]====================
highlight ColorColumn ctermbg=237
set colorcolumn=81
"call matchadd('ColorColumn', '\%>81v', 100)

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
exec "set listchars=tab:\uBB\uB7,trail:\uB7,nbsp:~"

"use R for Replace, not REPLACE mode, which I never use
"
nnoremap R :%s//g<LEFT><LEFT>

