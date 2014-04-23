"C/C++/java

:au BufNewFile,BufRead,BufEnter *.c,*.h,*.cpp,*.cxx,*.c++,*.java set ts=8 sw=2 softtabstop=2 noet fdm=syntax completefunc=ccomplete#Complete omnifunc=ccomplete#Complete

"vnoremap _g y:exe "grep /" . escape(@","\\/') . "/ *.c *.h *.cpp *.hpp"<CR>
