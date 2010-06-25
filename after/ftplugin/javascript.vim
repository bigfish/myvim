
    " See notes on |tlib#tag#Retrieve()|.
    let b:tlib_tags_extra = $EXT_HOME .'/tags'

    let b:ttagcomplete_collect='ttagcomplete#JavaScript'

    " Call |ttagcomplete#On()| and set 'omnifunc'.
    TTagCompleteOn

    " For code skeletons, use this:
    if exists('g:loaded_tskeleton') && g:loaded_tskeleton >= 402
        noremap <buffer> <c-x><c-g> :call ttagcomplete#CompleteSkeletons('m')<cr>
        inoremap <buffer> <c-x><c-g> <c-\><c-o>:call ttagcomplete#CompleteSkeletons('m')<cr>
    endif

