
" From settings above, this is only for comments
autocmd FileType text setlocal textwidth=78

" When eding a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "normal! g`\"" |
\ endif

"
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

autocmd BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:>

"fugitive tweaks
autocmd BufReadPost fugitive://* set bufhidden=delete

autocmd User fugitive
\ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
\   nnoremap <buffer> .. :edit %:h<CR> |
\ endif

augroup blanket
        au!

        "autocmd BufWritePost ~/shoppinglist/src/common/*.js :exe getClientCoverage
        "autocmd BufWritePost ~/shoppinglist/test/specs/common/*.js :exe getClientCoverage

        autocmd BufWritePost ~/shoppinglist/src/client/*.js :exe getClientCoverage
        autocmd BufWritePost ~/shoppinglist/test/specs/client/*.js :exe getClientCoverage

        autocmd BufWritePost ~/javascript/flux/src/client/*.js :exe getClientCoverage
        autocmd BufWritePost ~/javascript/flux/test/specs/client/*.js :exe getClientCoverage
        "autocmd BufWritePost ~/shoppinglist/src/server/*.js :exe getServerCoverage
        "autocmd BufWritePost ~/shoppinglist/test/specs/server/*.js :exe getServerCoverage
        autocmd BufWritePost ~/git/vim-blanket/js/*.js :call Blanket()
        autocmd BufWritePost ~/git/vim-blanket/test/spec/*.js :call Blanket()

        autocmd BufWritePost ~/work/msc/SecurityCenter/ui_test/spec/*.js  :call Blanket()
        autocmd BufWritePost ~/work/msc/SecurityCenter/src/ScriptUI/McMain/js/*.js :call Blanket()
augroup END

au BufNewFile,BufRead *.js :set expandtab sw=4 sts=4
au BufNewFile,BufRead *.jsx :set expandtab sw=4 sts=4
au BufNewFile,BufRead *.sh :set smarttab sw=4 sts=4
au BufNewFile,BufRead *.css :set smarttab sts=4 sw=4

" coffeescript -- move to after/ftplugin
:au BufEnter *.coffee setlocal tabstop=2
:au BufEnter *.coffee setlocal shiftwidth=2
:au BufEnter *.coffee setlocal expandtab

:au BufEnter *.vim setlocal softtabstop=4
:au BufEnter *.vim setlocal shiftwidth=4
:au BufEnter *.vim setlocal expandtab

"always cd to files dir
"this breaks fugitive Gdiff command!
"autocmd BufEnter,BufRead * :lcd %:p:h
"autocmd FileType idl set makeprg=idlj\ %
"let g:completekey="<C-Space>"
"cul option seems to slow rendering and cursor movement...
"augroup CurrentLineHighlight
    "au!
    "au InsertEnter,BufLeave * set nocul
    
    ""don't use cul on js files as it looks ugly with context coloring
    "au InsertLeave,BufEnter *.js set nocul
"augroup END
"XML Tidy
":autocmd BufNewFile,BufRead *.xml,*.mxml map <localleader>t <Esc>:1,$!tidy --input-xml true --indent-spaces 4 --indent-attributes yes -i -q<CR>
"markdown
"
"TEMPLATES
augroup templates
    autocmd BufNewFile *.html :0r $HOME/.vim/templates/html5.html
    autocmd BufNewFile *.sh :0r $HOME/.vim/templates/bash.sh
    autocmd BufNewFile /home/david/**/*_spec.js :0r /home/david/.vim/templates/mocha_spec.js
    autocmd BufNewFile Gruntfile.js :0r /home/david/.vim/templates/Gruntfile.js
    autocmd BufNewFile /home/david/books/angular/*.html :%d | 0r $HOME/.vim/templates/angular.html
    "cleverstack
    autocmd BufNewFile /home/david/clevertech/**/backend/**/models/orm/*Model.js :0r $HOME/.vim/templates/cleverstack/ORMModel.js | :%s/MODEL_NAME/\=expand('%:t:r')/g
    autocmd BufNewFile /home/david/clevertech/**/backend/**/controllers/*Controller.js :0r $HOME/.vim/templates/cleverstack/CleverController.js | :%s/BASENAME/\=substitute(expand('%:t:r'), 'Controller', '', '')/g
    autocmd BufNewFile /home/david/clevertech/**/backend/**/services/*Service.js :0r $HOME/.vim/templates/cleverstack/CleverService.js | :%s/BASENAME/\=substitute(expand('%:t:r'), 'Service', '', '')/g


":autocmd BufNewFile * silent! 0r $VIMHOME/templates/%:e.tpl   
augroup end

" autocmd that will set up the w:created variable
autocmd VimEnter * autocmd WinEnter * let w:created=1

" Consider this one, since WinEnter doesn't fire on the first window created when Vim launches.
" You'll need to set any options for the first window in your vimrc,
" or in an earlier VimEnter autocmd if you include this
"autocmd VimEnter * let w:created=1

" Example of how to use w:created in an autocmd to initialize a window-local option
" autocmd WinEnter *.js if !exists('w:created') | call JSCC_Colorize() | endif
"
autocmd FileType less set sw=4

au! FileType html setlocal complete=k~/.vim/dict/directives.txt,.,w,b,u,t,i,
au! FileType javascript setlocal complete=k~/.vim/dict/services.txt,.,w,b,u,t,i,

