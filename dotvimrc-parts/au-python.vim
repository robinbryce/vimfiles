"Python
" Use the below highlight group when displaying bad whitespace is desired
highlight BadWhitespace ctermbg=red guibg=red
:au BufNewFile,BufRead,BufEnter *.py,*.pyw,*.pyx set ts=4 sw=4 et
:au BufNewFile,BufRead,BufEnter *.py,*.pyx,*.pyx match BadWhitespace /^\t\+/
":au BufNewFile,BufRead,BufEnter,FileType python source ~/.vim/python.vimrc
":au BufNewFile,BufRead,BufEnter,FileType python source ~/.vim/pythoncomplete.vim
:au BufNewFile,BufRead,BufEnter,FileType *.py set makeprg=pychecker\ --only\ --limit=100\ %
:au BufNewFile,BufRead,BufEnter *.py,*.pyx set fdm=expr
:au BufNewFile,BufRead,BufEnter *.py set omnifunc=pythoncomplete#Complete
:au BufNewFile,BufRead,BufEnter *.py set completefunc=pythoncomplete#Complete 
