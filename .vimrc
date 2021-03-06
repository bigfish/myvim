"
" Maintainer:  David Wilhelm
"
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set shell=bash
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Enable file type detection.
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

set rtp+=~/.vim/bundle/vim-css-lint
set rtp+=/usr/local/opt/fzf

call vundle#begin()

if has('nvim')
Plugin 'neovim/node-host'
endif

"Plugin 'nishigori/vim-php-dictionary'
Plugin 'mileszs/ack.vim.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'kien/ctrlp.vim.git'
"Plugin 'bolasblack/csslint.vim'
Plugin 'junegunn/fzf.vim'
"Plugin 'mattn/gist-vim.git'
"Plugin 'bigfish/js-taglist.git'
Plugin 'majutsushi/tagbar'
"Plugin 'Valloric/ListToggle.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/nerdtree.git'
"Plugin 'tyru/open-browser.vim.git'
Plugin 'bigfish/snipmate.vim.git'
"Plugin 'joonty/vdebug.git'
"Plugin 'bigfish/vim4js.git'
"Plugin 'tpope/vim-cucumber.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'idanarye/vim-merginal'
"Plugin 'bigfish/vim-js-beautify.git'
"Plugin 'maksimr/vim-jsbeautify.git'
Plugin 'srcery-colors/srcery-vim'
"Plugin 'millermedeiros/vim-esformatter'
Plugin 'dag/vim-fish'

"disabling to debug perf:
"Plugin 'pangloss/vim-javascript'

"disabling to debug perf:
Plugin 'bigfish/vim-js-context-coloring.git'
Plugin 'airblade/vim-rooter'
"Plugin 'majutsushi/tagbar'
"Plugin 'craigemery/vim-autotag'

"disabling to debug perf:
Plugin 'bigfish/vim-eslint.git'

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
""Plugin 'guns/vim-clojure-static'

"disabling to debug perf:
Plugin 'mxw/vim-jsx'

""Plugin 'STRML/JSXHint'
""Plugin 'bigfish/vim-react.git'
Plugin 'bigfish/vim-react-es6-snippets'
""Plugin 'bigfish/vim-fireplace'

"disabling to debug perf:
Plugin 'cakebaker/scss-syntax.vim.git'

""Plugin 'bigfish/vim-empty-insert'
"Plugin 'ekalinin/Dockerfile.vim'

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'bigfish/vim-stylelint'
Plugin 'prettier/vim-prettier'

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

"colorscheme volcanic
"colorscheme vividchalk
colorscheme srcery

" ************************ OPTIONS ********************************

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"don't clutter up workspace with backup & swap file
set backupdir=/tmp
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

" TAB SETTINGS
set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

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
set switchbuf=useopen

so $HOME/.vim/functions.vim
so $HOME/.vim/commands.vim
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

set nocscopeverbose
cscope add $SOCDASH_HOME/src/cscope.out

"Plugin settings
let Tlist_Use_Right_Window=1

let g:bufExplorerDefaultHelp=0

"Gist options
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1

"use system clipboard
"set clipboard+=unnamedplus

let g:startify_bookmarks = [ '$HOME/.vimrc', '$HOME/.mappings.vim', '$HOME/.bashrc.vim' ]

"hide foldcolumn
set foldcolumn=0

" CTAGS these must be generated by ctags
"*************************************** TAGS ***************"
"lookup tags in current and all parent folders
set tags=tags;/
set autochdir

"shell scripting
iabbrev shb #!/bin/bash<cr>

"generate nice html
let html_ignore_folding=1
let html_use_css=1
let html_use_encoding = ""
let use_xhtml = 1

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
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_user_command = 'find %s -type f'
"let g:EasyMotion_leader_key = '<leader>m'
let g:Powerline_symbols = 'fancy'

let g:jshint_onwrite = 1
let g:jshint_goto_error = 0

let g:csslint_onwrite = 1
let g:csslint_goto_error = 0
"let g:netrw_liststyle=3 " Use tree-mode as default view
"let g:netrw_browse_split=4 " Open file in previous buffer
"let g:netrw_preview=1 " preview window shown in a vertically split
"let g:netrw_winsize=25
"gx to open file
let g:netrw_keepdir=0
let g:netrw_browsex_viewer= "gnome-open"

"this prevents messages from blocking
set cmdheight=2

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
set scrolloff=5

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
let g:airline_theme='dark'

  "if !exists('g:airline_symbols')
    "let g:airline_symbols = {}
  "endif

  "" powerline symbols
  "let g:airline_left_sep = ''
  "let g:airline_left_alt_sep = ''
  "let g:airline_right_sep = ''
  "let g:airline_right_alt_sep = ''
  "let g:airline_symbols.branch = ''
  "let g:airline_symbols.readonly = ''
  "let g:airline_symbols.linenr = ''

set noshelltemp
let g:js_context_colors_enabled = 0
let g:js_context_colors_jsx = 1
let g:js_context_colors_babel = 1
let g:javascript_enable_domhtmlcss = 1

"for vim-jsx
let g:jsx_ext_required = 0

let g:js_context_colors_debug = 0
let g:js_context_colors_allow_jsx_syntax = 0
let g:js_context_colors_usemaps = 1
"let g:js_context_colors_colorize_comments = 0
let g:js_context_colors_highlight_function_names = 1
"let g:js_context_colors_foldlevel = 2
"let g:js_context_colors_show_error_message = 1
"let g:js_context_colors_no_highlight_on_syntax_error = 0
let g:js_context_colors_block_scope_with_let = 1

let g:eslint_autofix = 1
let g:eslint_goto_error = 0
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let NERDTreeShowHidden = 1
let NERDTreeSortHiddenFirst = 1
"let g:js_context_colors_theme = 'js_context_colors'
"let g:js_context_colors_theme = 'js_context_colors_dark'
"let g:js_context_colors_theme = 'js_context_colors_bright'

let g:vdebug_options= {
\    "port" : 9000,
\    "server" : '',
\    "timeout" : 20,
\    "on_close" : 'detach',
\    "break_on_open" : 1,
\    "ide_key" : '',
\    "path_maps" : {},
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\    "watch_window_style" : 'expanded',
\    "marker_default" : '⬦',
\    "marker_closed_tree" : '▸',
\    "marker_open_tree" : '▾'
\}

let g:vdebug_options['path_maps'] = {"/media/sf_soc-dashboard/src/dashboard": "/Volumes/devhd/dev/soc-dashboard/src/dashboard",
                        \"/media/sf_soc-alerting-gui/src/AlertingGUI": "/Volumes/devhd/dev/soc-alerting-gui/src/AlertingGUI",
                        \"/media/sf_soc-csdb": "/Volumes/devhd/dev/soc-csdb",
                        \"/media/sf_tuning-dashboard": "/Volumes/devhd/dev/soc-tuning-dashboard/src"}

set wildmode=longest:list
if exists("&wildignorecase")
        set wildignorecase
endif

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*        " Linux/MacOSX

let php_sql_query=1
let php_htmlInStrings=1
let g:CSSLint_FileTypeList = ['css', 'less', 'sass']
let g:manpageview_winopen = "tab"
let g:python_host_prog = '/usr/bin/python'
let g:stylelint_goto_error = 0
let g:stylelint_autofix = 0

"highlight long lines
match ErrorMsg '\%>100v.\+'

let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_show_visibility = 1
let g:tagbar_show_linenumbers = 1
let g:tagbar_foldlevel = 2
let g:tagbar_autoshowtag = 1
"'let g:tagbar_autopreview = 1

nmap <C-e> <C-b>
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
let g:fzf_layout = { 'up': '~40%' }
