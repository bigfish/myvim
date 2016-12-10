
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
endfunction


function! GoToSpec()

    "define the src and spec dirs relative to common parent
    let srcdir = "src"
    let specdir = "test/specs"

    "get current file name and path
    let curpath = expand("%:p")
    let basepath_arr = split(curpath, '/')
    "remove the filename from the path array
    call remove(basepath_arr, -1)
    "get the root of the filename (no extension)
    let curfile = expand("%:t:r")
    "derive the name of the spec
    let specname = curfile . '_' . 'spec.js'
    "split the path on 'src' dir
    let relpath_arr = []
    let specpath = ""
    while (len(basepath_arr) > 0)
        "remove the last dir from the basepath and prepend into relpath
        let dir = remove(basepath_arr, -1)
        "if we reach the src dir, do not add to relpath, but construct the
        "specpath
        if (dir == srcdir)
            let specpath = '/' . join(basepath_arr, '/') . '/' . specdir . '/' . join(relpath_arr, '/') . '/' . specname
            break
        else
            call insert(relpath_arr, dir)
        endif
    endwhile

    exe 'vsplit' . specpath

endfunction

"simpler version of above -- no hierarchy
function! GoToSpec2()

    let srcdirs = ["src", "js"]
    let specdir = "spec"

    "get current file name and path
    let curpath = expand("%:p")
    let basepath_arr = split(curpath, '/')
    "remove the filename from the path array
    call remove(basepath_arr, -1)
    "get the root of the filename (no extension)
    let curfile = expand("%:t:r")
    "derive the name of the spec
    let specname = curfile . '_' . 'spec.js'

    "split the path on 'src' dir
    let relpath_arr = []
    let specpath = ""
    while (len(basepath_arr) > 0)
        "remove the last dir from the basepath and prepend into relpath
        let dir = remove(basepath_arr, -1)
        "if we reach the src dir, do not add to relpath, but construct the
        "specpath
        if index(srcdirs, dir) != -1
            let specpath = '/' . join(basepath_arr, '/') . '/' . specdir . '/' . specname
            break
        else
            call insert(relpath_arr, dir)
        endif
    endwhile

    exe 'vsplit' . specpath

endfunction

"go to Sass file for component, looks for styles dir in hierarchy
function! GoToCSS()

    let srcdir = "src"
    let sassdir = "styles"

    "get current file name and path
    let curpath = expand("%:p")
    let basepath_arr = split(curpath, '/')
    "remove the filename from the path array
    call remove(basepath_arr, -1)
    "get the root of the filename (no extension)
    let curfile = expand("%:t:r")
    "derive the name of the sass file
    let sassfile = curfile . '.scss'

    "split the path on 'src' dir
    let relpath_arr = []
    let sasspath = ""
    while (len(basepath_arr) > 0)
        "remove the last dir from the basepath and prepend into relpath
        let dir = remove(basepath_arr, -1)
        "if we reach the src dir, do not add to relpath, but construct the
        "sasspath
        if dir == srcdir
            let sasspath = '/' . join(basepath_arr, '/') . '/' . srcdir . '/' . sassdir . '/' . sassfile
            break
        else
            call insert(relpath_arr, dir)
        endif
    endwhile

    exe 'vsplit' . sasspath

endfunction

function! Only()
   :silent! s/describe(/describe.only(/
   :silent! s/it(/it.only(/
endfunction

"remove .only() from a spec
function! NotOnly()
   :silent! s/\.only//g
endfunction


"Adds ES6 module import for symbol under cursor
function! AddImport()
    let l:winview = winsaveview()
    "remember current pos
    let ident = expand("<cword>")
    if len(ident)
        normal gg
        let lnum = 1
        let curline = getline(".")
        while match(curline, '^\s*import') != -1
            "get name of import
            let matches = matchlist(curline, '^\s*import\s*\([$_0-9a-zA-Z]*\)')
            if len(matches)
                "echom matches[0]
            endif
            "bail if we already have import
            if index(matches, ident) > -1
                echo ident . " already imported!"
                call winrestview(l:winview)
                return
            endif
            "goto next line
            let lnum = lnum + 1
            call setpos(".", [0, lnum, 1])
            let curline = getline(".")
        endwhile
        "now we must be on first line, or first line after last contiguous import statement
        "create new empty line if current line is not empty
        if match(curline, '^\s*$') == -1
            normal O<Esc>
        endif
        call append(".", "")
        call setline(".", "import " . ident . " from '';")
        normal f'l
        startinsert
    endif
endfunction

"create a file from path under cursor  and edit it
function! EditFile()
    let curpath = expand("%:p:h") . "/"
    "assume filename is in quotes
    "let curfile = expand("<cWORD>")
    "get the bit in quotes..
    "clear yank register
    let @" = ""
    normal yi"
    "check if we got anything
    let curfile = @"
    "if we didn't try single quotes
    if curfile == ""
        normal yi'
        let curfile = @"
    endif
    if curfile == ""
        echom "unable to parse filename in quotes"
        return
    endif

    "strip of quotes
    "let curfile = substitute(curfile, "[^0-9_a-zA-Z/.\-]", "", "g")
    "if file doesn't have extension, use same as current
    "typically this is when importing es6 module
    "let curfile = substitute(curfile, "\\./", "", "g")
    let ext = expand("%:e")

    if stridx(curfile, "/") == -1
        if stridx(curfile, ".") == -1
            let curfile = curfile . "." . ext
        endif
    else
        let parts = split(curfile, "/")
        let endpart = parts[len(parts) - 1]
        if stridx(endpart, ".") == -1
            let curfile = curfile . "." . ext
        endif
    endif

    echom curfile

    let newfile = curpath . curfile
    if !filereadable(newfile)
        echo "creating " . newfile
    endif
    exe ":e" newfile
endfunction

