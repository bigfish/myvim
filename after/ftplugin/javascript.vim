map <localleader>b :JSBeautify<CR>

" Code coverage sign config
sign define Covered text=C  texthl=DiffAdd
sign define Uncovered text=U  texthl=Error

function! AddCoverageSigns(filePath, cvg)
    "echom 'AddCoverageSigns(' . a:filePath . ',' . string(a:cvg) . ')'
    exe 'sign unplace * file=' . a:filePath
    let cnt = 0
    for line in a:cvg
        let	cmd = 'sign place ' . cnt . ' line=' . cnt . ' name='
        if line >= 1
            let cmd .= 'Covered file=' . a:filePath
            exe cmd
        elseif line == 0
            let cmd .= 'Uncovered file=' . a:filePath
            exe cmd
        endif
        let cnt += 1
    endfor	
endfunction


function! Blanket(cmd, startDelim, endDelim)
    "echom 'Blanket(' . a:cmd . ',' . a:startDelim . ',' . a:endDelim . ')'
    let blanketOutput = system(a:cmd)
    let blanketOutput = substitute(blanketOutput, 'null', -1, "g")
    let outputLines = split(blanketOutput, '\n')
    let blanketJSON = ""
    let capture = 0
    for line in outputLines
        if capture && match(line, a:endDelim) != -1
            let capture = 0
        endif
        if capture
            let blanketJSON .= substitute(line, '\n', '', 'g')
        endif
        if match(line, a:startDelim) != -1
            let capture = 1
        endif
    endfor

    let coverage = {}
    if (blanketJSON != '')
        let coverage = eval(blanketJSON)
        "echo string(blanketOutput)
    else
        echo 'No coverage data available: fix failing tests'
        return
    endif
    "echom 'coverage=' . string(coverage)
    "normalize json-cov format to simpler format
    "same as global _$blanket object in browser
    if has_key(coverage, 'files')

        let cvgDict = {}
        for fileCvg in coverage.files
            let cvg = []
            "line 0 is always uncovered
            call add(cvg, -1)

            for [lineNo, lineCvg] in items(fileCvg.source)
                if lineCvg.coverage == "" 
                    call add(cvg, -1)
                else 
                    call add(cvg, lineCvg.coverage)
                end
            endfor

            let cvgDict[fileCvg.filename] = cvg

        endfor

    else
        let cvgDict = coverage
    end

    for [jsfile, cvg] in items(cvgDict)
        "use only the filename itself 

        if (stridx(jsfile, '/') != -1)
            let filename = split(jsfile, '/')[-1]
        else
            let filename = jsfile
        endif

        if bufloaded(filename)
            call AddCoverageSigns(filename, cvg)
        end
    endfor

endfunction
