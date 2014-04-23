" File: Comment.vim
"
" Purpose: functions to comment/uncomment lines
"
" Author: Ralf Arens <ralf.arens@gmx.de>
"
" Last Modified: 2001-06-06 22:20:23 CEST


" All functions support comment styles, these are:
"	"0": insert comment in first column
"	"1": insert comment in first column, plus one space after starting
"	     comment and one before ending comment
"	"2": insert starting comment after leading whitespace
"	"3": like "2" with additional spaces, as in "1"

" The functions take two arguments and one optional
"	style
"	starting_comment (eg. "//" in C++)
"	ending_comment (eg. "*/" in C) [optional]


fun! Comment0(startc, ...)
	let or = &report
	let &report= 9999
	let startc = escape(a:startc, '\/')
	if a:0 == 0
		exe 'sm/^/'.startc.'/'
	else
		let endc = escape(a:1, '\/')
		exe 'sm/^\(.*\)$/'.startc.'\1'.endc.'/'
	endif
	let &report = or
endfun


fun! UnComment0(startc, ...)
	let or = &report
	let &report= 9999
	let startc = escape(a:startc, '*^$.[]\/')
	if a:0 == 0
		exe 'sm/^'.startc.'//e'
	else
		let endc = escape(a:1, '*^$.[]\/')
		exe 'sm/^'.startc.'\(.*\)'.endc.'$/\1/e'
	endif
	let &report = or
endfun


fun! Comment1(startc, ...)
	let or = &report
	let &report= 9999
	let startc = escape(a:startc, '*^$.[]\/')
	if a:0 == 0
		exe 'sm/^/'.startc.' /'
	else
		let endc = escape(a:1, '\/')
		exe 'sm/^\(.*\)$/'.startc.' \1 '.endc.'/'
	endif
	let &report = or
endfun


fun! UnComment1(startc, ...)
	let or = &report
	let &report= 9999
	let startc = escape(a:startc, '*^$.[]\/')
	if a:0 == 0
		exe 'sm/^'.startc.' \=//e'
	else
		let endc = escape(a:1, '*^$.[]\/')
		exe 'sm/^'.startc.' \=\(.*\) \='.endc.'$/\1/e'
	endif
	let &report = or
endfun


fun! Comment2(startc, ...)
	let or = &report
	let &report= 9999
	let startc = escape(a:startc, '\/')
	if a:0 == 0
		exe 'sm/^\(\s*\)/\1'.startc.'/'
	else
		let endc = escape(a:1, '\/')
		exe 'sm/^\(\s*\)\(.*\)$/\1'.startc.'\2'.endc.'/'
	endif
	let &report = or
endfun


fun! UnComment2(startc, ...)
	let or = &report
	let &report= 9999
	let startc = escape(a:startc, '*^$.[]\/')
	if a:0 == 0
		exe 'sm/^\(\s*\)'.startc.'/\1/'
	else
		let endc = escape(a:1, '*^$.[]\/')
		exe 'sm/^\(\s*\)'.startc.'\(.*\)'.endc.'$/\1\2/'
	endif
	let &report = or
endfun


fun! Comment3(startc, ...)
	let or = &report
	let &report= 9999
	let startc = escape(a:startc, '\/')
	if a:0 == 0
		exe 'sm/^\(\s*\)/\1'.startc.' /'
	else
		let endc = escape(a:1, '\/')
		exe 'sm/^\(\s*\)\(.*\)$/\1'.startc.' \2 '.endc.'/'
	endif
	let &report = or
endfun


fun! UnComment3(startc, ...)
	let or = &report
	let &report= 9999
	let startc = escape(a:startc, '*^$.[]\/')
	if a:0 == 0
		exe 'sm/^\(\s*\) \='.startc.'/\1/'
	else
		let endc = escape(a:1, '*^$.[]\/')
		exe 'sm/^\(\s*\)'.startc.' \=\(.*\) \='.endc.'$/\1\2/'
	endif
	let &report = or
endfun



" CommentToggle(style, starting_comment, [ending_comment])
"	toggle the comments for one line or for a whole region
fun! CommentToggle(style, startc, ...)
	let startc = escape(a:startc, '*^$.[]\')
	let lin = getline(".")
	if a:0 == 0
		" only leading comment
		" check if line is commented
		if match(lin, '^\s*'.startc) == -1
			" line is uncommented -> comment
			call Comment(a:style, a:startc)
		else
			" line is commented -> uncomment
			call UnComment(a:style, a:startc)
		endif
	else
		" comment has two parts
		let endc = escape(a:1, '*^$.[]\')
		" check if line is commented
		if match(lin, '^\s*'.startc.'.*'.endc.'\s*') == -1
			" line is uncommented -> comment
			call Comment(a:style, a:startc, a:1)
		else
			" line is commented -> uncomment
			call UnComment(a:style, a:startc, a:1)
		endif
	endif
endfun


" CommentToggleSmart(style, starting_comment, [ending_comment])
"	toggle the comments for one line or for a whole region
"	if the first line of the region is not commented, the whole region
"	will be commented. and vice versa. double-commenting is avoided.
fun! CommentToggleSmart(style, startc, ...) range
	let first = a:firstline
	let lastl = a:lastline
	let startc = escape(a:startc, '*^$.[]\')
	let lin = getline(first)
	let current = line(".")
	if a:0 == 0
		" only leading comment
		" check if line is commented
		if match(lin, '^\s*'.startc) == -1
			" line is uncommented -> comment all lines
			exe 'norm '.first.'G'
			while first <= lastl
				call CommentSmart(a:style, a:startc)
				let first = first + 1
				norm j
			endwhile
		else
			" line is commented -> uncomment
			exe 'norm '.first.'G'
			while first <= lastl
				call UnComment(a:style, a:startc)
				let first = first + 1
				norm j
			endwhile
		endif
	else
		" comment has two parts
		let endc = escape(a:1, '*^$.[]\')
		" check if line is commented
		if match(lin, '^\s*'.startc.'.*'.endc.'\s*') == -1
			" line is uncommented -> comment
			exe 'norm '.first.'G'
			while first <= lastl
				call CommentSmart(a:style, a:startc, a:1)
				let first = first + 1
				norm j
			endwhile
		else
			" line is commented -> uncomment
			exe 'norm '.first.'G'
			while first <= lastl
				call UnComment(a:style, a:startc, a:1)
				let first = first + 1
				norm j
			endwhile
		endif
	endif
	exe 'norm '.current.'G'
endfun


" CommentSmart(style, start_comment, [end_comment])
"	comment a single line or whole region, but do not `double-comment' a
"	line
fun! CommentSmart(style, startc, ...)
	let startc = escape(a:startc, '*^$.[]\')
	let lin = getline(".")
	if a:0 == 0
		if match(lin, '^\s*'.startc) == -1
			call Comment(a:style, a:startc)
		endif
	else
		let endc = escape(a:1, '*^$.[]\')
		if match(lin, '^\s*'.startc.'.*'.endc.'\s*') == -1
			call Comment(a:style, a:startc, a:1)
		endif
	endif
endfun


" Comment(style, start_comment, [end_comment])
"	comment a single line or a whole region
fun! Comment(style, startc, ...)
	let or = &report
	let &report= 9999
	let startc = escape(a:startc, '\/')
	if a:0 == 0
		" only "startc" exists
		if a:style == "0"
			exe 'sm/^/'.startc.'/'
		elseif a:style == "1"
			exe 'sm/^/'.startc.' /'
		elseif a:style == "2"
			exe 'sm/^\(\s*\)/\1'.startc.'/'
		elseif a:style == "3"
			exe 'sm/^\(\s*\)/\1'.startc.' /'
		else
			echo "Style ".a:style." is not defined."
		endif
	else
		" "endc" exists also
		let endc = escape(a:1, '\/')
		if a:style == "0"
			exe 'sm/^\(.*\)$/'.startc.'\1'.endc.'/'
		elseif a:style == "1"
			exe 'sm/^\(.*\)$/'.startc.' \1 '.endc.'/'
		elseif a:style == "2"
			exe 'sm/^\(.*\)$/'.startc.' \1 '.endc.'/'
		elseif a:style == "3"
			exe 'sm/^\(\s*\)\(.*\)$/\1'.startc.' \2 '.endc.'/'
		else
			echo "Style ".a:style." is not defined."
		endif
	endif
	let &report = or
endfun


" UnComment(style, start_comment, [end_comment])
"	uncomment a single line or a whole region
"	no error messages will be given, if substitute fails
fun! UnComment(style, startc, ...)
	let or = &report
	let &report= 9999
	let startc = escape(a:startc, '*^$.[]\/')
	if a:0 == 0
	" only "startc" exists
		if a:style == "0"
			exe 'sm/^'.startc.'//e'
		elseif a:style == "1"
			exe 'sm/^'.startc.' \=//e'
		elseif a:style == "2"
			exe 'sm/^\(\s*\)'.startc.'/\1/'
		elseif a:style == "3"
			exe 'sm/^\(\s*\) \='.startc.'/\1/'
		else
			echo "Style ".a:style." is not defined."
		endif
	else
	" "endc" exists also
		let endc = escape(a:1, '*^$.[]\/')
		if a:style == "0"
			exe 'sm/^'.startc.'\(.*\)'.endc.'$/\1/e'
		elseif a:style == "1"
			exe 'sm/^'.startc.' \=\(.*\) \='.endc.'$/\1/e'
		elseif a:style == "2"
			exe 'sm/^\(\s*\)'.startc.'\(.*\)'.endc.'$/\1\2/'
		elseif a:style == "3"
			exe 'sm/^\(\s*\)'.startc.' \=\(.*\) \='.endc.'$/\1\2/'
		else
			echo "Style ".a:style." is not defined."
		endif
	endif
	let &report = or
endfun


" the autocommand section
"	mappings for calling CommentToggle() according to filetype
map <C-#> :call CommentToggleSmart("0", "#")<CR>
au FileType asm :map <C-#> :call CommentToggleSmart("0", ';')<CR>
au FileType c :map <C-#> :call CommentToggleSmart("0", '/*', '*/')<CR>
au FileType cpp :map <C-#> :call CommentToggleSmart("0", '//')<CR>
au FileType html :map <C-#> :call CommentToggleSmart("0", "<!--", '-->')<CR>
au FileType slang :map <C-#> :call CommentToggleSmart("0", '%')<CR>
au FileType slrnrc :map <C-#> :call CommentToggleSmart("0", '%')<CR>
au FileType slrnsc :map <C-#> :call CommentToggleSmart("0", '%')<CR>
au FileType tex :map <C-#> :call CommentToggleSmart("0", '%')<CR>
au FileType vim :map <C-#> :call CommentToggleSmart("0", '"')<CR>
au FileType xdefaults :map <C-#> :call CommentToggleSmart("0", '!')<CR>
au BufEnter *.sci :map <C-#> :call ComToggle('//',"")<CR>



" vim: set noet ts=8 sw=8 sts=8:
