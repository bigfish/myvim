"map <localleader>b :JsBeautify<CR>
set expandtab
set sw=2
set ts=2

function! g:SortPropTypes()
  "remember currentpos
  let save_pos = getpos(".")

  let propTypesStartLine = search('^\w\+.propTypes\s=\s{', 'cw')
  echom propTypesStartLine

  if propTypesStartLine > 0
    let propTypesEndLine = search('^};')
    let range = string(propTypesStartLine + 1) . "," . string(propTypesEndLine - 1)
    let ex = ":" . range . " sort i"
    exec ex
  endif

  call setpos('.', save_pos)
endf

autocmd! BufWrite <buffer> :call SortPropTypes()

" Code coverage stuff-- should be moved to separate plugin
" Code coverage sign config
"sign define Covered text=C  texthl=DiffAdd
"sign define Uncovered text=U  texthl=Error

"function! AddCoverageSigns(filePath, cvg)
    ""echom 'AddCoverageSigns(' . a:filePath . ',' . string(a:cvg) . ')'
    "exe 'sign unplace * file=' . a:filePath
    "let cnt = 0
    "for line in a:cvg
        "let	cmd = 'sign place ' . cnt . ' line=' . cnt . ' name='
        "if line >= 1
            "let cmd .= 'Covered file=' . a:filePath
            "exe cmd
        "elseif line == 0
            "let cmd .= 'Uncovered file=' . a:filePath
            "exe cmd
        "endif
        "let cnt += 1
    "endfor
"endfunction

"function! ParseFileName(filename)

        "let matches = matchlist(a:filename, '\v(.*)(_spec)?\.js')
        "if len(matches)
            "let basename = matches[1]
        "else
            "let basename = split(a:filename, '\.')[0]
        "endif

        "return basename
"endfunction

"function! Blanket()
    ""echom 'Blanket()'
    "if g:disable_blanket
        "return
    "endif

    "let startDelim = 'COVERAGE_START'
    "let endDelim = 'COVERAGE_END'
    "let curfilename = expand('%:t')
    "let curfilebasename = ParseFileName(curfilename)
    "let cmd = 'grunt --no-color spec --spec=' . curfilebasename
    "let blanketOutput = system(cmd)
    "let blanketOutput = substitute(blanketOutput, 'null', -1, "g")
    "let outputLines = split(blanketOutput, '\n')
    "let blanketJSON = ""
    "let capture = 0
    "for line in outputLines
        "if capture && match(line, endDelim) != -1
            "let capture = 0
        "endif
        "if capture
            "let blanketJSON .= substitute(line, '\n', '', 'g')
        "endif
        "if match(line, startDelim) != -1
            "let capture = 1
        "endif
    "endfor

    ""echom blanketJSON
    "let coverage = {}
    "if (blanketJSON != '')
        "let coverage = eval(blanketJSON)
        ""echo string(blanketOutput)
    "else
        "echo 'No coverage data available: fix failing tests'
        "return
    "endif
    ""echom 'coverage=' . string(coverage)
    ""normalize json-cov format to simpler format
    ""same as global _$blanket object in browser
    "if has_key(coverage, 'files')

        "let cvgDict = {}
        "for fileCvg in coverage.files
            "let cvg = []
            ""line 0 is always uncovered
            "call add(cvg, -1)

            "for [lineNo, lineCvg] in items(fileCvg.source)
                "if lineCvg.coverage == ""
                    "call add(cvg, -1)
                "else
                    "call add(cvg, lineCvg.coverage)
                "end
            "endfor

            "let cvgDict[fileCvg.filename] = cvg

        "endfor

    "else
        "let cvgDict = coverage
    "end

    "for [jsfile, cvg] in items(cvgDict)
        ""remove the file:// prefix"
        "if stridx(jsfile, 'file://') == 0
            "let filepath = strpart(jsfile, 6)
        "else
            "let filepath = jsfile
        "endif

        "if bufloaded(filepath)
            "call AddCoverageSigns(filepath, cvg)
        "end
    "endfor

"endfunction
