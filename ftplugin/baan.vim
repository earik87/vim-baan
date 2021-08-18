if exists("b:baan_inv_loaded")
  " Script is already loaded
  finish
endif

let b:baan_inv_loaded = "yes"

" Settings
setlocal shiftwidth=8
setlocal softtabstop=0

" This inserts automatically the commented line for the new lines. 
setlocal comments=b:\|*

" Vim commented out the lines with comment string below. This can be used for
" commentary plugin.. 
setlocal commentstring=\|*\%s

" AutoComplete
" This can be improved. Baan_dictionary.txt still does not have everything.
let g:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let g:path = g:path . '\baan_dictionary.txt'
setlocal complete+=k
let &l:dictionary .= ',' .. g:path
setlocal iskeyword+=-

" project name for marking; possibly something like lnd2-12345, or 800-12345.
" This will be determined from the top of the script, from an indentation.. This
" should only be executed for readonly files. 
let b:project = "#12345" "Marker to be used when you press f3, f4, f5...

"search from back |* SOL". Regular expressions are tricky. 
"For more info; help pattern.
function SearchForLastSolutionNumber()
	let l:search_pattern = "* SOL "
	let l:flags = "b" "Search from back for solution (SOL) marker.
	let l:markerposition = search(l:search_pattern, l:flags)
	let l:solnumber = 0

	if l:markerposition == 0
		return 0
	else
		let l:solnumber = strpart(getline(l:markerposition), 7, 7)
	endif
	
	if l:solnumber != 0
		return l:solnumber
	else
		return 0
	endif
endfunction

"Only search for last solution number function for non-read only baan files.
if !&readonly
	let b:solutionnumber = SearchForLastSolutionNumber()

	if b:solutionnumber == 0 
		echo "Marker was not found by vim-baan plugin. \nYou can enter manually by defining b:project variable for easy marking."
	else
		let b:project = "#" . b:solutionnumber
		"I dont know why but if message is just one line, vim does not
		"show it. Thats why there are two lines here.
		echo "Marker found with solution number: \n" . b:solutionnumber
	endif
endif

"Mappings for adding quick markers in the script. A better keyboard shortcut can
"be selected in the future.
noremap <F3> :let @v="\|" . b:project . "." . "n"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>
noremap <F4> :let @v="\|" . b:project . "." . "sn"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>
noremap <F5> :let @v="\|" . b:project . "." . "en"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>

noremap <F6> :let @v="\|" . b:project . "." . "o"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>
noremap <F7> :let @v="\|" . b:project . "." . "so"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>
noremap <F8> :let @v="\|" . b:project . "." . "eo"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>

" end of script
