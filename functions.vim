
function! Hyphenize()
s/\([A-Z]\)/-\L\1/
endfunction

function! Camelize()
s/-\([a-z]\)/\U\1/
endfunction

"css helper convert camel case to hyphen case & back (must have selection):
"note - will only work on first instance on a line, and if there isn't one,
"it will probably do something unintended. But it works great with Flex CSS
"assuming one rule per line
command! -range Hyphenate <line1>,<line2>call Hyphenize()
command! -range CamelCase <line1>,<line2>call Camelize()

function! WPMStartCount()
        execute ':w'
        let g:wpm_start_word_count = system('wc -w ' . shellescape(expand('%')) . "|cut -d' ' -f1")
        let g:wpm_start_time = localtime()
endfunction

function! WPMLog(wpm)
        let logStr = system("date +%s")
        let logStr = substitute(logStr, '\n$', '', '')
        let logStr = logStr . '|' . a:wpm
        call system('echo "' . logStr . '" >> ~/.wpm_log')
        echom a:wpm
endfunction


function! SaveFile()
        execute ':w'
endfunction

function! SilentSaveFile()
        execute ':silent! w'
endfunction

function! WPMStopCount()
        execute ':w'
        let g:wpm_end_word_count = system('wc -w ' . shellescape(expand('%')) . "|cut -d' ' -f1")
        let g:wpm_end_time = localtime()
        let new_words = g:wpm_end_word_count - g:wpm_start_word_count
        let secs = g:wpm_end_time - g:wpm_start_time
        let wpm = (str2float(new_words) / secs) * 60
        let wpm = float2nr(wpm)
        "if wpm > 0
        call WPMLog(wpm)
        "endif
endfunction

augroup wpm
        au!
        autocmd InsertEnter *.txt  :call WPMStartCount()
        autocmd InsertLeave *.txt  :call WPMStopCount()
        "autocmd InsertLeave *.txt :call SilentSaveFile()
augroup END

augroup netrw_dvorak_fix
    autocmd!
    autocmd filetype netrw call Fix_netrw_maps_for_dvorak()
augroup END

"augroup save_on_edit
    "autocmd InsertLeave * :call SaveFile()
    "autocmd!
"augroup END

function! Fix_netrw_maps_for_dvorak()
    "use dvorak up-down motions
    nnoremap <buffer> t j
    nnoremap <buffer> n k
    "use s for netrw sorting -- can use l for moving right
    "use S to move to right window -- overrides edit sort order of netrw 
    nnoremap <buffer> S <c-w>l         
endfunction

"let g:funcjs_colors = []
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set relativenumber
  endif
endfunc
