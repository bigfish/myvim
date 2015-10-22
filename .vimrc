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

"call pathogen#infect()

" Enable file type detection.
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

set rtp+=~/.vim/bundle/vim-msc

call vundle#begin()

Plugin 'mileszs/ack.vim.git'
Plugin 'bling/vim-airline'
"Plugin 'bigfish/angular-vim-snippets.git'
Plugin 'kien/ctrlp.vim.git'
"Plugin 'mattn/gist-vim.git'
"Plugin 'bigfish/js-taglist.git'
"Plugin 'Valloric/ListToggle.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/nerdtree.git'
"Plugin 'tyru/open-browser.vim.git'
Plugin 'bigfish/snipmate.vim.git'
"Plugin 'joonty/vdebug.git'
"Plugin 'bigfish/vim4js.git'
"Plugin 'tpope/vim-cucumber.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'bigfish/vim-js-beautify.git'

Plugin 'pangloss/vim-javascript'
Plugin 'bigfish/vim-js-context-coloring.git'

Plugin 'bigfish/vim-jshint.git'
"Plugin 'groenewege/vim-less.git'
"Plugin 'mustache/vim-mustache-handlebars.git'
Plugin 'bigfish/vim-ragtag.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'mhinz/vim-startify.git'
Plugin 'tpope/vim-surround.git'
Plugin 'bigfish/vim-unimpaired.git'
Plugin 'guns/xterm-color-table.vim.git'
Plugin 'mattn/emmet-vim.git'
"Plugin 'marijnh/tern_for_vim'
"Plugin 'guns/vim-clojure-static'
Plugin 'mxw/vim-jsx'
"Plugin 'STRML/JSXHint'
"Plugin 'bigfish/vim-react.git'
"Plugin 'bigfish/vim-react-snippets'
"Plugin 'bigfish/vim-fireplace'
Plugin 'bigfish/vim-msc.git'
Plugin 'cakebaker/scss-syntax.vim.git'

if has('nvim')
Plugin 'neovim/node-host'
endif

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

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
so $HOME/.vim/autocommands.vim
so $HOME/.vim/macros.vim

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
"set complete=.,w,b,u,t,i
set complete=.,w,b,u,i
set completeopt=menu,preview

set nocst
"do omnicomplete (on supported filetypes
imap <C-o> <C-x><C-o>
imap <C-u> <C-x><C-u>
"imap <C-k> <C-x><C-k>
"file completion: mnemonic: (L)ookup file... C-f is taken in insert by movement mapping
imap <C-l> <C-x><C-f>


highlight SignColumn term=standout ctermfg=14 ctermbg=NONE guifg=Cyan guibg=black
highlight Search guibg=cyan cterm=NONE ctermbg=cyan ctermfg=black
highlight Search guibg=cyan cterm=NONE ctermbg=cyan ctermfg=black

"Plugin settings
let Tlist_Use_Right_Window=1

let g:bufExplorerDefaultHelp=0

"Gist options
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1

"use system clipboard
"set clipboard+=unnamedplus

let g:startify_bookmarks = [ '~/.vimrc', '~/.mappings.vim', '~/.bashrc.vim' ]

"hide foldcolumn
set foldcolumn=0

" CTAGS these must be generated by ctags
"*************************************** TAGS ***************"
"lookup tags in current and all parent folders
:set tags=tags;/
set autochdir

"shell scripting
iabbrev shb #!/bin/bash<cr>

"generate nice html
:let html_ignore_folding=1
:let html_use_css=1
:let html_use_encoding = ""
:let use_xhtml = 1

"enable static folds
"set foldmethod=marker

"no dashes in folds
set fillchars="fold:,vert:"

let g:maintainer='{ "name": "David Wilhelm", "web": "http://dafishinsea.com" }'

hi clear CursorLine
hi CursorLine ctermbg=18
"hi CursorLine ctermbg=237

"help copypaste to work
set clipboard=unnamed

"gitv conf
let g:Gitv_DoNotMapCtrlKey = 1
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = '/tmp'
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file':  '\v\.(h|cpp|vcxproj|targets)$'
      \}
let g:ctrlp_user_command = 'find %s -type f'
"let g:EasyMotion_leader_key = '<leader>m'
let g:Powerline_symbols = 'fancy'

let g:jshint_onwrite = 1
let g:jshint_goto_error = 0

"let g:netrw_liststyle=3 " Use tree-mode as default view
"let g:netrw_browse_split=4 " Open file in previous buffer
"let g:netrw_preview=1 " preview window shown in a vertically split
"let g:netrw_winsize=25
"gx to open file
let g:netrw_keepdir=0
let g:netrw_browsex_viewer= "gnome-open"

"this prevents messages from blocking
set cmdheight=2

set encoding=utf-8
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

"let getClientCoverage = "call Blanket('grunt --no-color mocha:json','COVERAGE_START', 'COVERAGE_END')"
let getClientCoverage = "call Blanket('grunt --no-color spec --spec=','COVERAGE_START', 'COVERAGE_END')"

let getServerCoverage = "call Blanket('grunt --no-color server-json-cov','Running \"mochaTest:json\" (mochaTest) task','Done, without errors.')"

"quick command line access
let g:mustache_abbreviations = 1

"====[ Make text over 80 chars long stand out ]====================
"highlight ColorColumn ctermbg=237
"set colorcolumn=81
"call matchadd('ColorColumn', '\%>81v', 100)

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
exec "set listchars=tab:\uBB\uB7,trail:\uB7,nbsp:~"
set nolist

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif
"experimental : save on leave insert mode
"au InsertLeave *  execute ':w'
"this could be made into a toggle-able function with -s
"this causes issue in command line window

"debug autocmds
"set verbose=9
"
inoremap ' ''<left>
inoremap " ""<left>
inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" old vim-powerline symbols
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

let g:airline_theme='night'

set noshelltemp
let g:js_context_colors_enabled = 1
let g:javascript_enable_domhtmlcss = 1       
let g:jsx_ext_required = 0

let g:js_context_colors_debug = 1
let g:js_context_colors_usemaps = 0
"let g:js_context_colors_enabled = 1
"let g:js_context_colors_colorize_comments = 0
let g:js_context_colors_highlight_function_names = 1
"let g:js_context_colors_foldlevel = 2
"let g:js_context_colors_show_error_message = 1
"let g:js_context_colors_no_highlight_on_syntax_error = 0
let g:js_context_colors_block_scope_with_let = 1
