"note: this gets called everytime the filetype plugin gets called.. 
"ie, whenever filetype changes.. so avoid putting a lot of code in here
"
" See notes on |tlib#tag#Retrieve()|.
let b:tlib_tags_extra = $EXT_HOME .'/tags'

let b:ttagcomplete_collect='ttagcomplete#JavaScript'

" Call |ttagcomplete#On()| and set 'omnifunc'.
" using completefunc so we don't clobber javascript omnicompletion
" SuperTab will call completefunc if found first
TTagCompleteOn complete

" For code skeletons, use this:
if exists('g:loaded_tskeleton') && g:loaded_tskeleton >= 402
    noremap <buffer> <c-g> :call ttagcomplete#CompleteSkeletons('m')<cr>
    "inoremap <buffer> <c-x><c-g> <c-\><c-o>:call ttagcomplete#CompleteSkeletons('m')<cr>
    inoremap <buffer> <c-s> <c-\><c-o>:call ttagcomplete#CompleteSkeletons('m')<cr>
endif

