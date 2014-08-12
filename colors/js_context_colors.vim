" Vim color file
"
" Author: David Wilhelm <dewilhelm@gmail.com>
"
" Note: Used by the JavaScript Context Colors plugin
" to highlight function scopes differently by level
" top level = 0
" To override these colors, copy this colorscheme
" to your ./vim/colors/ dir and change as desired

"echom "JSCC: loading highlighting groups"

hi JSCC_Level_0 ctermfg=252
hi JSCC_Level_1 ctermfg=10
hi JSCC_Level_2 ctermfg=11
hi JSCC_Level_3 ctermfg=172
hi JSCC_Level_4 ctermfg=1
hi JSCC_Level_5 ctermfg=161
hi JSCC_Level_6 ctermfg=63

hi Comment ctermfg=243
hi Todo ctermfg=black ctermbg=220

if exists('g:js_context_colors_colorize_comments') && !g:js_context_colors_colorize_comments
    hi link javaScriptComment              Comment
    hi link javaScriptLineComment          Comment
    hi link javaScriptDocComment           Comment
    hi link javaScriptCommentTodo          Todo
endif
