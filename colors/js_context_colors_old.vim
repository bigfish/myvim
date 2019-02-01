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
"yellow    #b58900  3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
"orange    #cb4b16  9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
"red       #dc322f  1/1 red      160 #d70000 50  65  45 220  50  47   1  79  86
"magenta   #d33682  5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
"violet    #6c71c4 13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
"blue      #268bd2  4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
"cyan      #2aa198  6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  63
"green     #859900  2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60

"hi JSCC_Level_0 ctermfg=136
"hi JSCC_Level_1 ctermfg=166
"hi JSCC_Level_2 ctermfg=160
"hi JSCC_Level_3 ctermfg=125
"hi JSCC_Level_4 ctermfg=61
"hi JSCC_Level_5 ctermfg=33
"hi JSCC_Level_6 ctermfg=37
"hi JSCC_Level_7 ctermfg=64

hi JSCC_Level_0 ctermfg=76
hi JSCC_Level_1 ctermfg=37
hi JSCC_Level_2 ctermfg=33
hi JSCC_Level_3 ctermfg=61
hi JSCC_Level_4 ctermfg=125
hi JSCC_Level_5 ctermfg=160
hi JSCC_Level_6 ctermfg=166
hi JSCC_Level_7 ctermfg=136

hi JSCC_UndeclaredGlobal ctermfg=172

"hi JSCC_Level_0 ctermfg=3
"hi JSCC_Level_1 ctermfg=2
"hi JSCC_Level_2 ctermfg=6
"hi JSCC_Level_3 ctermfg=4
"hi JSCC_Level_4 ctermfg=39
"hi JSCC_Level_5 ctermfg=69
"hi JSCC_Level_6 ctermfg=212
"hi JSCC_Level_7 ctermfg=9


hi Comment ctermfg=243
hi Todo ctermfg=black ctermbg=220

if exists('g:js_context_colors_colorize_comments') && !g:js_context_colors_colorize_comments
    hi link javaScriptComment              Comment
    hi link javaScriptLineComment          Comment
    hi link javaScriptDocComment           Comment
    hi link javaScriptCommentTodo          Todo
endif
