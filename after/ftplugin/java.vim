let b:tlib_tags_extra = $HOME.'/.vim/tags/jdk/tags'
let b:ttagcomplete_collect='ttagcomplete#Java'  
"
if exists('g:loaded_tskeleton') && g:loaded_tskeleton >= 402
    noremap <buffer> <c-x><c-g> :call ttagcomplete#CompleteSkeletons('m')<cr>
    inoremap <buffer> <c-x><c-g> <c-\><c-o>:call ttagcomplete#CompleteSkeletons('m')<cr>
endif

TTagCompleteOn
