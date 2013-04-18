
nnoremap <localleader>b :Bp<CR>

function! OpenPHPFunctionDoc(fn)
		let doc_url = "http://ca1.php.net/manual/en/function." . a:fn. ".php"
		:silent execute "!gnome-open " . doc_url . " >/dev/null 2>&1"
endfunction

nnoremap <localleader>f :call OpenPHPFunctionDoc(expand("<cword>"))<CR>:redraw!<CR>
