
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

"au BufNewFile,BufRead *.jsx :set expandtab sw=4 sts=4
au BufNewFile,BufRead *.sh :set smarttab sw=4 sts=4
au BufNewFile,BufRead *.svg :set filetype=xml
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
    autocmd BufNewFile *.svg :0r $HOME/.vim/templates/svg.svg
    autocmd BufNewFile *.xml :0r $HOME/.vim/templates/xml.xml
    "autocmd BufNewFile /home/david/**/*_spec.js :0r /home/david/.vim/templates/mocha_spec.js
    "autocmd BufNewFile /home/david/work/msc/**/*_spec.js :0r /home/david/.vim/templates/mocha_module_spec.js
    autocmd BufNewFile Gruntfile.js :0r /home/david/.vim/templates/Gruntfile.js
    autocmd BufNewFile /home/david/books/angular/*.html :%d | 0r $HOME/.vim/templates/angular.html
    autocmd BufNewFile .editorconfig :0r $HOME/.vim/templates/.editorconfig
    autocmd BufNewFile *.php :0r $HOME/.vim/templates/default.php
    autocmd BufNewFile /Volumes/devhd/dev/securityportal/sp-core/client/spec/components/**/*_spec.js
                \ :0r $HOME/.vim/templates/mocha_component_spec.js
    autocmd BufNewFile /Volumes/devhd/dev/securityportal/sp-core/client/spec/components/**/*Container_spec.js
                \ :0r $HOME/.vim/templates/mocha_container_spec.js
    autocmd BufNewFile /Volumes/devhd/dev/securityportal/sp-core/client/spec/reducers/*_spec.js
                \ :0r $HOME/.vim/templates/mocha_basic_spec.js
    autocmd BufNewFile /Volumes/devhd/dev/securityportal/analytics-couchdb/spec/**/*_spec.js
                \ :0r /Users/dwilhelm/.vim/templates/couchdb_view_spec.js

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

"au! FileType html setlocal complete=k~/.vim/dict/directives.txt,.,w,b,u,t,i,
"au! FileType javascript setlocal complete=k~/.vim/dict/services.txt,.,w,b,u,t,i,
"au! FileType php setlocal complete=k~/.vim/bundle/vim-php-dictionary/dict/PHP.dict,.,w,b,u,t,i,

" mocha specs
" [m]ocha [o]nly
au BufNewFile,BufRead *_spec.js nnoremap <localleader>o :call Only()<CR>

" [n]ot [o]nly
au BufNewFile,BufRead *_spec.js nnoremap <localleader>n :call NotOnly()<CR>

" auto-close quickfix window
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" make .template files php filetype
au! BufRead *.template :set ft=php
autocmd  FileType  php setlocal omnifunc=phpcomplete_extended#CompletePHP

" eliminate trailing whitespace
au! BufWritePre * :silent! %s/\s\+$//g

" format sass, css
"au! BufWritePre *.scss normal gg=G

"autocmd FileType javascript noremap <buffer>  <localleader>f :call JsBeautify()<cr>

"now using esformatter for javascript/jsx
"au FileType javascript nnoremap <silent> <C-f> :Esformatter<CR>
"au FileType javascript vnoremap <silent> <C-f> :EsformatterVisual<CR>

"use stylefmt for css/scss
"au FileType css nnoremap <silent> <C-f> :Stylefmt<CR>
"au FileType css vnoremap <silent> <C-f> :StylefmtVisual<CR>
"au FileType scss nnoremap <silent> <C-f> :Stylefmt<CR>
"au FileType scss vnoremap <silent> <C-f> :StylefmtVisual<CR>

" for json
autocmd FileType json noremap <buffer> <C-f> :call JsonBeautify()<cr>

" for jsx
"autocmd FileType jsx noremap <buffer> <localleader>f :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <localleader>f :call HtmlBeautify()<cr>
" for css or scss
"autocmd FileType css,scss noremap <buffer> <localleader>f :call CSSBeautify()<cr>

"autocmd FileType javascript vnoremap <buffer>  <localleader>f :call RangeJsBeautify()<cr>
"autocmd FileType json vnoremap <buffer> <localleader>f :call RangeJsonBeautify()<cr>
"autocmd FileType jsx vnoremap <buffer> <localleader>f :call RangeJsxBeautify()<cr>
"autocmd FileType html vnoremap <buffer> <localleader>f :call RangeHtmlBeautify()<cr>
"autocmd FileType css vnoremap <buffer> <localleader>f :call RangeCSSBeautify()<cr>

"au BufNewFile * startinsert

autocmd BufRead .stylelintrc :set ft=json
autocmd BufRead .eslintrc :set ft=json

"autocmd InsertEnter *.js :JSContextColorToggle
"autocmd InsertLeave *.js :JSContextColorToggle

"autocmd InsertEnter *.js :call JSCC_Disable()
"autocmd InsertLeave *.js :call JSCC_Enable()
