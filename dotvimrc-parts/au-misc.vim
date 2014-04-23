" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.

au BufNewFile *.py,*.pyx,*.c,*.h,*.cc,*.cpp,*.hpp set fileformat=unix
"autocmd BufEnter * call Fcd_bufferdir()


"XML
:au BufNewFile,BufRead,BufEnter *.xml set ts=2 sw=2 et


"Makefiles
:au BufNewFile,BufRead,BufEnter *akefile* set noexpandtab nosmarttab
:au BufNewFile,BufRead,BufEnter *.mak set noexpandtab nosmarttab
:au BufNewFile,BufRead,BufEnter *.mk set noexpandtab nosmarttab
:au BufNewFile,BufRead,BufEnter *akefile* let g:complType=""

