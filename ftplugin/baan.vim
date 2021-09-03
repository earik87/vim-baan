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

" This makes sure we have status bar enabled for promp messages.
setlocal laststatus=2

" Create title and add marker into it.
setglobal titlestring=
setglobal titlestring+=%f
setglobal titlestring+=\ marker:
setglobal titlestring+=\ %{b:project}

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
let b:project = "" "Marker to be used when you press f3, f4, f5...

"``````````` Functions ```````````
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

function CommentLine()
	:normal! 0i|
endfunction

function ChangeMarker()
    call inputsave()
    echo "Current marker: " . b:project
    let l:returnstring = input("Enter new marker: ")
    if l:returnstring != ""
	let b:project = l:returnstring
    endif

    call inputrestore()
endfunction

" Function Delete all behind the |* and ends with an n or o
function UncommentLine()
	let s = getline(line("."))
	" Check if first character is a pipe

	if strpart(s, 0, 1) == "|"
		.s/|/
	endif
	" Delete everything behand the |# signe, as long as it ends on n or o
	exe ".s/\|#.*[on]\\>//e" 
	" Clean up whithe spaces
	.s/\s*$//e
endfunction

"Only search for last solution number function for non-read only baan files.
if !&readonly
	let b:solutionnumber = SearchForLastSolutionNumber()

	if b:solutionnumber == 0 
		let b:project = ""
	else
		let b:project = "#" . b:solutionnumber
	endif
endif

"Mappings for adding quick markers in the script. 
noremap <silent> <F1> :let @v="\|" . b:project . "." . "sn"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>
noremap <silent> <F2> :let @v="\|" . b:project . "." . "en"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>
noremap <silent> <F3> :let @v="\|" . b:project . "." . "n"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>
noremap <silent> <F4> :let @v="\|" . b:project . "." . "o"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>
noremap <silent> <F5> :let @v="\|" . b:project . "." . "so"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>
noremap <silent> <F6> :let @v="\|" . b:project . "." . "eo"<CR>80A <ESC>65\|C<ESC>"vp:.ret!<CR><CR>

" Mappings for comment/uncomment line.
noremap <silent> <F11>	:cal	CommentLine()<CR><CR>
noremap <silent> <F12>	:cal	UncommentLine()<CR><CR>

" Mappings for adding comment block.
noremap <silent> cb	O|79a*80|DyypO|*

" Mappings for changing b:project which is used for quick marker.
noremap <silent> cm	:cal	ChangeMarker()<CR><CR>

" Baan menu.
menu BD\ tools.\|\.\.\.\.\.\.\.\.sn<Tab>F1  <F1>
menu BD\ tools.\|\.\.\.\.\.\.\.\.en<Tab>F2  <F2>
menu BD\ tools.\|\.\.\.\.\.\.\.\.n<Tab>F3   <F3>
menu BD\ tools.\|\.\.\.\.\.\.\.\.o<Tab>F4   <F4>
menu BD\ tools.\|\.\.\.\.\.\.\.\.so<Tab>F5  <F5>
menu BD\ tools.\|\.\.\.\.\.\.\.\.eo<Tab>F6  <F6>
menu BD\ tools.CommentLine<Tab>F11	    <F11>
menu BD\ tools.UncommentLine<Tab>F12	    <F12>
" menu BD\ tools.Cleanup\ script<Tab>Alt+F12  <A-F12>	
menu BD\ tools.Comment\ Block<Tab>cb	    cb
menu BD\ tools.Change\ Marker<Tab>cm	    cm

" end of script
