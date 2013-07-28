map <localleader>b :JSBeautify<CR>

" Code coverage sign config
sign define Covered text=C  texthl=DiffAdd
sign define Uncovered text=U  texthl=Error

function! AddCoverageSigns(filePath, cvg)
		exe 'sign unplace * file=' . a:filePath
		let cnt = 0
		for line in a:cvg
				let	cmd = 'sign place ' . cnt . ' line=' . cnt . ' name='
				if line == 1
						let cmd .= 'Covered file=' . a:filePath
						exe cmd
				elseif line == 0
						let cmd .= 'Uncovered file=' . a:filePath
						exe cmd
				endif
				let cnt += 1
		endfor	
endfunction


function! Blanket()

		let blanketOutput = system("grunt mocha:verbose")
		let blanketOutput = substitute(blanketOutput, 'null', -1, "g")
		let outputLines = split(blanketOutput, '\n')
		let blanketJSON = ""
		let capture = 0


		for line in outputLines
				if capture && match(line, 'COVERAGE_END') != -1
						let capture = 0
				endif
				if capture
						let blanketJSON .= line
				endif
				if match(line, 'COVERAGE_START') != -1
						let capture = 1
				endif
		endfor

		let coverage = {}


		exe 'let coverage = ' . blanketJSON
		
		for [jsfile, cvg] in items(coverage)
				"normalize filepath --
				"assume is under src/
				let srcPos = stridx(jsfile, 'src')
				let filepath = 'src' . strpart(jsfile, srcPos + 3)
				if bufloaded(filepath)
						call AddCoverageSigns(filepath, cvg)
				end
		endfor

endfunction


map <localleader>c :call Blanket()<CR>
