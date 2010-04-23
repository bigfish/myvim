"helper functions for flex programming - MXML related

"externalize string -- replace with keys and insert into properties file
function! ExternalizeStrings()
	
	"prompt for prefix
	let prefix = input("Prefix: ")
	let propsFile = "~/work/sky/scorpius/management/ui/wanop/locale/en_US/Wanop.properties"
	"replacing everything with a text or label property
	"create a Dictionary told externalized strings
	let props = {}
	"check this is a mxml file
	if expand("%:e") != "mxml"
		echo "ExternalizeStrings may only be called in an MXML file"
		return
	endif
	"goto start but remember current line pos to restore later
	exec "normal mc"
	exec "normal gg"
	"insert script tag and import statement after first tag, if not found
	if search("import com.bluecoat.utils.resources.*","") == 0
		call cursor(2,0)
		"goto start of second tag (first is xml tag)
		call search(">")
		call append(".",["	<mx:Script>","		<![CDATA[","			import com.bluecoat.utils.resources.*;","		]]>","	</mx:Script>"])
	endif

	exec "normal gg"
	while search('label=\|text=', "W") > 0
		let textId = ""
		let textStr = ""
		"assume tag is on same line
		let lineStr = getline(".")
		"check that id exists -- will be used for key if it exists,
		"otherwise first 3 words will be used
		let ids = matchlist(lineStr, '\s\+id\s*=\s*"\([^"]\+\)"\s*')
		if len(ids) > 1 
			let textId=ids[1]
		endif
		"check that not already externalized or bound to something else
		if matchstr(lineStr, '\s\+\(label\|text\)\s*=\s*"{[^}]*}"\s\+') == ""
			"that text property exists 
			let texts = matchlist(lineStr, '\s\+\(label\|text\)\s*=\s*"\([^"]*\)"\s*', 0)
			"second match will be text
			if len(texts) > 2 
				let textStr = texts[2]
			else
				Decho("this shouldn't happen...")
			endif
			"use id for key if it exists
			if textId != ""
				let keyname = prefix . "_" . textId
				let props[keyname] = textStr
			else
				let words = matchlist(textStr, '\(\<\w*\>\)\+\s*\(\<\w*\>\)\?\s*\(\<\w*\>\)\?', 0)
				let keyname = prefix . "_"
				let wordnum = 0
				for word in words
					if wordnum == 0
						"skip whole match
					elseif wordnum == 1
						"lowercase first word
						let word = substitute(word, ".*", "\\L\\0", "")
						let keyname = keyname . word
					elseif wordnum >= 2
						"uppercase
						let word = substitute(word, ".", "\\U\\0", "")
						"add word to keyname if not unique
						if has_key(props, keyname)
							let keyname = keyname . word
						else
							"if it is unique we can quit here
							break
						endif
					endif
					"
					let wordnum = wordnum + 1
				endfor
				"add to properties dictionary
				let props[keyname] = textStr
			endif
			"
			"replace literal text with externalized reference
			let rep = substitute(lineStr, '\(label\|text\)="[^"]*"' , "\\1=\"{xstr(" . "'" . keyname . "'" .")}\"", "" )
			call setline(".", rep)
		endif

	endwhile

	"go back to original position
	exec "normal 'c"
	"return if no results
	if len(props) == 0
		return
	endif
	"update properties file
	let propsFileBufName = bufname(propsFile)
	"open props file if not open
	if propsFileBufName == ""
		exec "sp " . propsFile
		let propsFileBufName = bufname(propsFile)
	endif
	let props_bufnum = bufnr(propsFileBufName)
   "Check whether propsfile is open in one of the windows
        let props_winnum = bufwinnr(props_bufnum)
        if props_winnum != -1
            " Jump to the window which has the props buffer if we are not
            " already in that window
            if winnr() != props_winnum
                exe props_winnum . "wincmd w"
            endif
        else
            " Create a new props buffer
             exe "split +buffer" . props_bufnum
        endif
	"goto end of file
	  "generate properties file
       for key in sort(keys(props))
		   "construct new property line "
		   let newprop = key . " = " . props[key]
		   "got start of file
		   normal gg
		   "check for existing key
		   if search('^' . key)
			   "replace line -- NB : onus is on user to prevent clobbering old
			   "keys -- use prefix
			   call setline(".", newprop)
			   echo "replaced key for " . key
		   else
			call append(line("$"), newprop)
		   endif
       endfor
	   "goto end
	   normal G

endfunction
