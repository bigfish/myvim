" *haxe.vim*	Plugin for ActionScript 3 files
" 
" Author: David Wilhelm <dewilhelm@gmail.com>
" Last Modified: March 13 2010
" Description: Automatically adds import statements, defines an omnicomplete
" function for Haxe code 
" Requirements: Vim 7.0, Ctags, tags for Flash (included), tags for any
" projects your working on. 
" Mappings: 
" <Leader>i HXAddImport
" 		Add import for current word
" <Leader>a	HXAddAllImports
" 		Add imports for current file
" Note: Will set 'completefunc' for .as files
" Settings:	no_as3_maps (global) disables maps in this plugin
" 	asdoc_browser  : command to open asdoc URLs with 

"prevent duplicate loading
"if exists("b:did_ftplugin")
	"finish
"endif
"let b:did_ftplugin = 1

"save and restore compatible setting
let s:save_cpo = &cpo
set cpo&vim

"*************************************************
"******************* MAPPINGS ********************
"*************************************************

" for development, I have removed <unique> requirement from mappings
" top allow easy reloading of file without errors
if !hasmapto('<Plug>HXAddImport')
	"map <unique> <Leader>i <Plug>HXAddImport
	map <Leader>i <Plug>HXAddImport
endif
"noremap <unique> <script> <Plug>HXAddImport <SID>AddImport
noremap <script> <Plug>HXAddImport <SID>AddImport
noremap <SID>AddImport :call <SID>AddImport(expand("<cword>"))<CR>

if !hasmapto('<Plug>HXAddAllImports')
	"map <unique> <Leader>a <Plug>HXAddAllImports
	map <Leader>a <Plug>HXAddAllImports
endif
"noremap <unique> <script> <Plug>HXAddAllImports <SID>AddAllImports
noremap <script> <Plug>HXAddAllImports <SID>AddAllImports
noremap <SID>AddAllImports :call <SID>AddAllImports(expand("<cword>"))<CR>

if !hasmapto('<Plug>HXOpenHXDoc')
	map <Leader>h <Plug>HXOpenHXDoc
endif
noremap <script> <Plug>HXOpenHXDoc <SID>OpenHXDoc
noremap <SID>OpenHXDoc :call <SID>OpenHXDoc(expand("<cword>"))<CR>

if !hasmapto('<Plug>HXRemoveUnusedImports')
	"map <unique> <Leader>r <Plug>HXRemoveUnusedImports
	map <Leader>r <Plug>HXRemoveUnusedImports
endif
"noremap <unique> <script> <Plug>HXRemoveUnusedImports <SID>RemoveUnusedImports
noremap <script> <Plug>HXRemoveUnusedImports <SID>RemoveUnusedImports
noremap <SID>RemoveUnusedImports :call <SID>RemoveUnusedImports()<CR>

if !hasmapto('<Plug>HXFormatImports')
	"map <unique> <Leader>f <Plug>HXFormatImports
	map <Leader>f <Plug>HXFormatImports
endif
"noremap <unique> <script> <Plug>HXFormatImports <SID>FormatImports
noremap <script> <Plug>HXFormatImports <SID>FormatImports
noremap <SID>FormatImports :call <SID>FormatImports()<CR>

if !hasmapto('<Plug>HXAddProperty')
	"map <unique> <Leader>d <Plug>HXOpenASDoc
	map <Leader>p <Plug>HXAddProperty
endif
"noremap <unique> <script> <Plug>HXOpenASDoc <SID>OpenASDoc
noremap <script> <Plug>HXAddProperty <SID>AddProperty
noremap <SID>AddProperty :call <SID>AddProperty(expand("<cword>"))<CR>

if !hasmapto('<Plug>HXAddMethod')
	"map <unique> <Leader>d <Plug>HXOpenASDoc
	map <Leader>m <Plug>HXAddMethod
endif
"noremap <unique> <script> <Plug>HXOpenASDoc <SID>OpenASDoc
noremap <script> <Plug>HXAddMethod <SID>AddMethod
noremap <SID>AddMethod :call <SID>AddMethod(expand("<cword>"))<CR>

"****************** InstrumentClass (d = debug) ***********
if !hasmapto('<Plug>HXInstrumentClass')
	map <Leader>d <Plug>HXInstrumentClass
endif
noremap <script> <Plug>HXInstrumentClass <SID>InstrumentClass
noremap <SID>InstrumentClass :call <SID>InstrumentClass()<CR>

"****************** Generate Project Tags (t = tags) ***********
if !hasmapto('<Plug>HXGenerateProjectTags')
	map <Leader>t <Plug>HXGenerateProjectTags
endif
noremap <script> <Plug>HXGenerateProjectTags <SID>GenerateProjectTags
noremap <SID>GenerateProjectTags :call <SID>GenerateProjectTags()<CR>

if !hasmapto('<Plug>HXNoTrace')
	map <Leader>n <Plug>HXNoTrace
endif
noremap <script> <Plug>HXNoTrace <SID>NoTrace
noremap <SID>NoTrace :call <SID>NoTrace()<CR>

" COMMANDS
if !exists(":HXAddImport")
	command -nargs=1 HXAddImport	:call s:AddImport(<q-args>)
endif

if !exists(":HXAddAllImports")
	command -nargs=0 HXAddAllImports	:call s:AddAllImports()
endif

if !exists(":HXRemoveUnusedImports")
	command -nargs=0 HXRemoveUnusedImports	:call s:RemoveUnusedImports()
endif

if !exists(":HXFormatImports")
	command -nargs=0 HXFormatImports	:call s:FormatImports()
endif

if !exists(":HXInstrumentClass")
	command -nargs=0 HXInstrumentClass	:call s:InstrumentClass()
endif

if !exists(":HXGenerateProjectTags")
	command -nargs=0 HXGenerateProjectTags :call s:GenerateProjectTags()
endif

if !exists(":HXOpenHXDoc")
	command -nargs=1 HXOpenHXDoc :call s:OpenHXDoc(<q-args>)
endif
" MENU ITEMS
"noremenu <script> Plugin.HX.Add\ Import	<SID>AddImport
noremenu <script> Plugin.HX.Remove\ Unused\ Imports	<SID>RemoveUnusedImports
noremenu <script> Plugin.HX.Format\ Imports	<SID>FormatImports

" FUNCTIONS
function! s:GetImportFromClass(class)
	"lookup tag
	let result_import = ""
	let tagmatches = taglist('^'.a:class.'$')
	"use first match.TODO: prompt if more than one match / show menu
	if len(tagmatches) > 0
		let classtag = get(tagmatches, 0)
		" try to get import extended attribute
		let import = get(classtag, "import")
		"import = "0" when it doesn't exist
		if(len(import) > 1)
			let result_import = import
		else
			"else get import from filepath
			let filepath = get(classtag, "filename")
			let import = s:GetImportFromFilePath(filepath)
			if (len(import) > 1)
				let result_import = import
			endif
		endif
	endif
	return result_import
endfunction

function! s:GetCurrentPackage()
	"we could get it from package declaration ....
	"this works even in an empty file
	let curpkg = tr(expand("%:p:h"), "/", ".")
	let curpkg = strpart(curpkg, stridx(curpkg, 'src') + 4)
	return curpkg
endfunction

function! s:AddImport(class)
	"save position
	exec "normal mcHmt"
	"get import statement for class
	let imp = s:GetImportFromClass(a:class)

	"bail if no import was obtained
	if(imp=="")
		return
	endif
	"only add import if not already added
	if search(imp) > 0
		"go back to original position
		exec "normal 'tzt`c"
		return
	endif

	"don't add if in same package as current file
	let importPackage = s:GetPackageFromImport(imp)
	let curpkg = s:GetCurrentPackage()
	if (importPackage == curpkg)
		return
	else 
		"let curline = s:GotoEndOfImports()
		exec "normal gg"
		let start = search("\_^\s*import","W")
		if(start)
			let lastImportLine = start
			while search("\_^\s*import", "W")
				if line(".") > lastImportLine + 1
					"remove empty lines
					let emStart = lastImportLine + 1
					let emEnd = line(".")-1
					exec emStart.','.emEnd."d"
				endif
				let lastImportLine = line(".")
			endwhile
			let end = line(".")
			call append(end, "import ".imp.";")
			let end = end + 1
			"sort
			exec start.",".end." sort"
		else 
			"insert after package or comments
			exec "normal gg"
			let insertPos = search("{")
			call append(insertPos,  "import ".imp.";")
		endif
		"go back to original position
		exec "normal 'tzt`c"
	endif
	call s:FormatImports()
endfunction

function! s:RemoveUnusedImports()
	"save position
	exec "normal mcHmt"
	" go to top
	exec "normal gg"
	let start = search('^\s*import',"W")
	" give up if no imports found
	if(start)
		let importlines = []
		call add(importlines, getline("."))
		while search('^\s*import', "W")
			call add(importlines, getline("."))
		endwhile
		"remove all imports
		let end = expand(".") 
		exec start.",".end."d"
		let numImports = len(importlines)
		let i = numImports
		while i >= 0
			let i = i - 1
			" extract classname from import
			let import = importlines[i]
			let className = strpart(import, strridx(import, '.'))

			let className = matchlist(className, '\.\(\k*\)\s*\;')[1]
			if(search(className,"Wn") == 0)
				"remove import	
				call remove(importlines, i)
			endif
		endwhile
		"restore imports 
		let insertPos = start - 1
		for importline in importlines
			call append(insertPos, importline)
			let insertPos = insertPos + 1
		endfor
	else
		"go back to original position
		exec "normal 'tzt`c"
		return
	endif
	"go back to original position
	exec "normal 'tzt`c"
	call s:FormatImports()
endfunction

function! s:FormatImports()
	exec "normal mcHmt"
	exec "normal gg"
	let start = search('^\s*import',"W")
	" give up if no imports found
	if start > 0
		let lastImportLine = start
		let pkgName = s:GetPackageFromImportStatement(getline("."))
		let firstLetter = strpart(pkgName,0,1) 
		"add blank line
		while search('^\s*import', "W")
			let import_statement = getline(".")
			let pkgName = s:GetPackageFromImportStatement(getline("."))
			let newFirstLetter = strpart(pkgName,0,1)
			if(newFirstLetter != firstLetter && line(".") == lastImportLine + 1 )
				exec "normal O"
			endif
			let firstLetter = newFirstLetter
			let lastImportLine = line(".")
		endwhile

	endif

	exec "normal 'tzt`c"
endfunction

function! s:GetPackageFromImportStatement(import_statement)
	let pkgName = ""
	let matches = matchlist(a:import_statement, 'import\s*\(.*\)')
	if(len(matches) > 0)
		let pkgName = matches[1]
	endif
	return pkgName
endfunction

function! s:GetPackageFromImport(import)
	let pkg = strpart(a:import, 0, strridx(a:import, '.'))
	return pkg
endfunction

function! s:GetImportFromFilePath(filepath)
	let import = ""
	let importpath = matchlist(a:filepath, 'src\/\([^\.]*\)')
	if (len(importpath) > 1)
		let import = tr(importpath[1], "/", ".")
	endif
	return import
endfunction

function! s:AddAllImports()
	" save position
	exec "normal mcHmt"
	"get current package
	let curpkg = tr(expand("%:p:h"), "/", ".")
	let curpkg = strpart(curpkg, stridx(curpkg, 'src') + 4)
	let imports = []
	" get list of all classes used in file
	let classes = s:GetAllClasses()

	for class in classes
		"get import statement for class
		let imp = s:GetImportFromClass(class)
		"bail if no import was obtained
		if(imp == "")
			continue
		endif
		"only add import if not already added
		if search(" ".imp.";") > 0
			continue
		endif
		"don't add if in same package as current file
		"apparently, in Haxe, we need to import class in same package ...
		"let importPackage = s:GetPackageFromImport(imp)
		"if (importPackage == curpkg)
			"continue
		"endif
		"OK, add import to list
		call add(imports, imp)
	endfor

	if len(imports) > 0
		"now add all imports at once
		exec "normal gg"
		let start = search('^\s*import',"W")
		if(start > 0)
			let lastImportLine = start
			while search('^\s*import', "W")
				if line(".") > lastImportLine + 1
					"remove empty lines
					let emStart = lastImportLine + 1
					let emEnd = line(".")-1
					exec emStart.','.emEnd."d"
				endif
				let lastImportLine = line(".")
			endwhile
			let end = line(".")
			"now add all imports at once
			for import in imports
				call append(end, "import ".import.";")
				let end = end + 1
			endfor
			"sort
			exec start.",".end." sort"
		else 
			"insert after package or comments
			exec "normal gg"
			let insertpos = search("{")
			let start = insertpos + 1
			for import in imports
				call append(insertpos,  "import ".import.";")
				let insertpos = insertpos + 1
			endfor
			"sort
			exec start.",".insertpos." sort"
		endif

		exec "normal 'tzt`c"
		call s:FormatImports()
	else
		"nothing changed
	endif

	exec "normal 'tzt`c"

endfunction

perl << EOF
sub addClass 
{
	my $all = shift;
	my $class = shift;
	if(index($all,"|$class|") == -1){
		$all .= "$class|";
	}
	return $all
}
sub addClasses
{
	my $all = shift;
	my @classes = shift;
	my $class;
	foreach(@classes){
		$class = $_;
		if(index($all,"|$class|") == -1){
			$all .= "$class|";
		}
	}
	return $all
}
sub parseLine {

	my $classesStr = VIM::Eval("b:allclasses");
	my $line = $_;
	my @matches;
	my $class;
	#extends Xxx
	if ($line =~ /extends\s+([A-Z]\w*)/){
		$classesStr = addClass($classesStr, $1);
	}
	#interfaces -- got max of 2 working --- TODO --support more
	if ($line =~ /implements\s+([A-Z]\w*)\,?\s?([A-Z]\w*)?/){
		$classesStr = addClass($classesStr, $1);
		if($2){
			$classesStr = addClass($classesStr, $2);
		}
	}

	#new Xxx
	@matches = $line =~ /new\s+([A-Z]\w*)/g;
	if(@matches > 0) {
		$classesStr = addClasses($classesStr, @matches);
	}

	#as Xxx
	@matches =  $line =~ /as\s+([A-Z]\w*)/g;
	if(@matches > 0) {
		$classesStr = addClasses($classesStr, @matches);
	}
	#is Xxx
	@matches = $line =~ /is\s+([A-Z]\w*)/g;
	if(@matches > 0) {
		$classesStr = addClasses($classesStr, @matches);
	}
	#foo:Xxx
	@matches = $line =~ /\w+\s*:\s*([A-Z]\w*)/g;
	if(@matches > 0){
		$classesStr = addClasses($classesStr, @matches);
	}
	#Foo.xx
	@matches = $line =~ /\W([A-Z]\w*)\.\w+/g;
	if(@matches > 0){
		$classesStr = addClasses($classesStr, @matches);
	}
	#Type(foo) - but not function definitions
	@matches = $line =~ /(?<!function)\s*\W([A-Z]\w*)\([^\)]*\)/g;
	if(@matches > 0){
		$classesStr = addClasses($classesStr, @matches);
	}
	#Function return value
	@matches = $line =~ /\w+\s*\([^\)]*\)\s*:\s*([A-Z]\w*)/g;
	if(@matches > 0){
		$classesStr = addClasses($classesStr, @matches);
	}
	#exceptional lowercase classes... add in here
	#xstr
	if($line =~ /xstr\([^\)]*\)/){
		$classesStr = addClass($classesStr, 'xstr');
	}

	#VIM::Msg($classesStr);
	VIM::DoCommand("let b:allclasses='".$classesStr."'")
}
EOF

function! s:GetAllClasses()

	let b:allclasses="|"
	perldo parseLine
	return split(b:allclasses,"|")
	"TODO: use haxe compiler to get list of all properties in the current
	"class and their types (classes)

endfunction

function! s:AddProperty(propname)

	"goto position just before class constructor (if found)
	let className = expand("%:t:r")
	echo "className: ".className
	" save position
	exec "normal mb"
	let constr = search('\_^\s*public\s\+function\s\+'.className.'\s*(')
	if(constr)
		"trigger snippet for property
		if strpart(a:propname, 0, 1) == "_"
			call append(constr-1,"		pri")
		else
			call append(constr-1,"		pub")
		endif
		exec 'normal ko'
		exec 'normal kA	'.a:propname.'	'
		
	endif
	
	"print "type 'b to return to previous position"

endfunction

function! s:AddMethod(methodname)
    "goto end of class -- before last }
    exec 'normal G'
	let EOC = search('^\s*}\s*$', 'bc')
    "trigger snippet for property
    if strpart(a:methodname, 0, 1) == "_"
        call append(EOC-1,"	prifunc")
    else
        call append(EOC-1,"	pubfunc")
    endif
	exec 'normal ko'
	exec 'normal kA	'.a:methodname.'	'

endfunction

"*******************************************
"****************** FOLDING ****************
"*******************************************

function! ActionScriptFold() 
	setl foldtext=FoldText()
	"remember position
	normal mp
	normal gg
	normal zE
	while search('function','W') > 0
		"find start brace -- will be on same or next line
		if match(getline("."),"{") !~ -1 
			"if foldlevel(line(".")) < 2
				normal f{
				normal zf%
				"open fold
				normal zo
			"endif
		elseif match(getline(line(".")+1),"{") !~ -1
			"if foldlevel(line(".")+1) < 2
				normal jf{
				normal zf%
				"open fold
				normal zo
				"prevent infinite loop by moving down before next search
				normal j 
			"endif
		endif
	endwhile
	"restore pos
	normal 'p
endfunction

"add trace statements after each function signature to trace the function
"calls and argument values
function! s:InstrumentClass()
	"get Class name to prepend 
	let cls = expand("%:t:r")
	"remember position 
	normal mp
	"goto start
	normal gg

	while search('function','W') > 0
		"1 copy function signature into variable"
		let sig = getline(".")
		"2 construct trace statement"
		let sig = matchstr(sig, '\w\+([^)]*)')
		let fn = matchstr(sig, '\w\+')
		let st = stridx(sig, "(") + 1
		let en = stridx(sig, ")")
		"args is everything in brackets"
		let args = strpart(sig, st, en-st)
		"niceargs is formatted for tracing"
		let niceargs = ""
		let argslist = matchlist(args, '\(\w\+\):\w\+')
		if len(argslist) > 0
			if stridx(args, ",") > 0 
				let commapos = 0
				let niceargs = niceargs . "(\" + "
				while match(args, ',', commapos + 1) != -1
					let oldcommapos = commapos
					let commapos = match(args, ',', oldcommapos + 1) 
					let myarg = strpart(args, oldcommapos, commapos - oldcommapos)
					let argname = matchlist(myarg, '\(\w\+\):\w\+')[1]
					let niceargs = niceargs . argname . " + \", \" + "
					"let niceargs = niceargs . argname
				endwhile
				"get the last one
				let lastarg = strpart(args, commapos, len(args)-commapos)
				let lastargname = matchlist(lastarg, '\(\w\+\):\w\+')[1]
				let niceargs = niceargs . lastargname . " + \")"

			else
				"only one argument
				let niceargs = "(\" + " . argslist[1] . " + \")"
			endif
		else
			let niceargs = "()"
		endif

		let trace = "trace(\"" . cls .":" . fn . niceargs ."\" );"
		"find start brace -- will be on same or next line
		if match(getline("."),"{") !~ -1 
			"opening brace is on same line..."
			"open new line"
			normal o
			"add previously constructed trace statement
			call setline(".", trace)

		elseif match(getline(line(".")+1),"{") !~ -1
			"opening brace is on next line..."
			normal jf{
			normal o
			call setline(".", trace)
			
			"prevent infinite loop by moving down before next search
			normal j 
		endif
	endwhile


endfunction

"customize folds
function! FoldText()
	return substitute(getline(v:foldstart), '{.*', '{...}', '')
endfunction

"quick build - still sends errors to quickfix
"and doesn't change makeprg
function! CompileCurrentFile()
	let s:save_makeprg = &makeprg
	set makeprg=mxmlc\ %
	:make
	let &makeprg = s:save_makeprg 
endfunction

function! s:NoTrace()
	:%s/^.*trace(.*).*$\n//gc
endfunction

function! s:GenerateProjectTags()
	"requires external scripts
	exec '!gen_project_tags %:p'
endfunction

"restore compatible option
 let &cpo = s:save_cpo

"Open ASDoc for Symbol 
function! s:OpenHXDoc(class)
	let tagmatches = taglist('^'.a:class.'$')
	"use first match.TODO: prompt if more than one match / show menu
	if len(tagmatches) > 0
		let classtag = get(tagmatches, 0)
		" try to get import extended attribute
		let asdoc = get(classtag, "asdoc")
		" empty attribute = "0"
		if len(asdoc) > 1
			"open in browser
			let asdoc =  escape (asdoc, "#?&;|%")
			if(exists("asdoc_browser"))
				execute "!".g:asdoc_browser." ".asdoc
			elseif has("macunix")
				execute '!open ' . asdoc
			elseif has("unix")
				execute "!gnome-open " . asdoc 
			else
				echo "No default browser found. Please set asdoc_browser"
			endif
		endif
	endif
endfunction
